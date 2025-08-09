import SwiftUI
import FirebaseAuth


struct NewPostView: View {
    @Environment(\.dismiss) var dismiss
    @State private var postBody: String = ""
    
    var onPostCreated: () -> Void

    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Post Body")) {
                    TextEditor(text: $postBody)
                        .frame(height: 150)
                }
            }
            .navigationTitle("New Post")
                 .toolbar {
                     ToolbarItem(placement: .confirmationAction) {
                         Button("Submit") {
                             createPost()
                         }
                         .disabled(postBody.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                     }
                     ToolbarItem(placement: .cancellationAction) {
                         Button("Cancel") {
                             dismiss()
                         }
                     }
                 }
        }    }
    
    private func createPost() {
        let userId = Auth.auth().currentUser?.uid ?? "" // 🔐 Firebase user ID

          guard !userId.isEmpty else {
              print("User ID is missing")
              return
          }
        
        guard var components = URLComponents(string: "http://127.0.0.1:8080/api/posts") else { return }

        
        components.queryItems = [
             URLQueryItem(name: "userId", value: userId)
         ]

        
        guard let url = components.url else { return }


        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let postData = ["body": postBody]
        guard let jsonData = try? JSONEncoder().encode(postData) else { return }

        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error creating post:", error)
                return
            }

            DispatchQueue.main.async {
                onPostCreated()
                dismiss()
            }
        }.resume()
    }
}
