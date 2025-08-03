import SwiftUI
import FirebaseAuth

struct NewCommentView: View {
    let postId: String
    var onSuccess: () -> Void

    @State private var commentBody: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            TextEditor(text: $commentBody)
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                .padding(.bottom, 4)

            Button("Submit Comment") {
                createComment()
            }
            .disabled(commentBody.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }

    private func createComment() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        var components = URLComponents(string: "http://192.168.1.11:8080/api/comments")!
        components.queryItems = [
            URLQueryItem(name: "userId", value: userId),
            URLQueryItem(name: "postId", value: postId)
        ]

        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let commentData = ["body": commentBody]
        request.httpBody = try? JSONEncoder().encode(commentData)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Failed to post comment:", error)
                return
            }

            DispatchQueue.main.async {
                commentBody = ""
                onSuccess()
            }
        }.resume()
    }
}
