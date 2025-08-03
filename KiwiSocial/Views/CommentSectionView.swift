import SwiftUI

struct CommentSectionView: View {
    let postId: String
        @State private var comments: [Comment] = []
        @State private var showNewComment = false

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Comments")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        showNewComment.toggle()
                    }) {
                        Label("Add", systemImage: "plus.bubble")
                            .font(.subheadline)
                    }
                }

                if showNewComment {
                    NewCommentView(postId: postId) {
                        fetchComments()
                        showNewComment = false
                    }
                }

                if comments.isEmpty {
                    Text("Be the first to leave a comment!")
                        .foregroundColor(.gray)
                        .italic()
                } else {
                    ForEach(comments) { comment in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(comment.author.username)
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Text(comment.createdAt.formatted())
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Text(comment.body)
                                .font(.body)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                    }
                }
            }
            .onAppear(perform: fetchComments)
        }

        func fetchComments() {
            guard let url = URL(string: "http://192.168.1.11:8080/api/comments/\(postId)") else { return }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching comments:", error)
                    return
                }
                

                if let httpResponse = response as? HTTPURLResponse {
                    print("Status code:", httpResponse.statusCode)
                }

                guard let data = data, !data.isEmpty else {
                    print("No data received")
                    return
                }
                

                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .custom { decoder in
                        let container = try decoder.singleValueContainer()
                        let dateString = try container.decode(String.self)

                        guard let date = formatter.date(from: dateString) else {
                            throw DecodingError.dataCorruptedError(in: container,
                                debugDescription: "Invalid date format: \(dateString)")
                        }

                        return date
                    }
                    
                    
                    let decoded = try decoder.decode([Comment].self, from: data)
                    DispatchQueue.main.async {
                        self.comments = decoded.sorted(by: { $0.createdAt > $1.createdAt })
                    }
                } catch {
                    print("Decoding error:", error)
                    print("Raw response:", String(data: data, encoding: .utf8) ?? "Invalid UTF8")
                }
            }.resume()
        }
}
