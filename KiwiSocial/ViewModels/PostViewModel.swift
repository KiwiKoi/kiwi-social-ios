import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []

    func fetchPosts() {
        guard let url = URL(string: "http://127.0.0.1:8080/api/posts") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching posts:", error)
                return
            }

            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            
            guard let data = data else { return }

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

                
                let decodedPosts = try decoder.decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.posts = decodedPosts
                }
                
                
            } catch {
                print("Failed to decode posts:", error)
            }
        }.resume()
    }
}
