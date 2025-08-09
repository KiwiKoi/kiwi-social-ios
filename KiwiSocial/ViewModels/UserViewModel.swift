import Foundation
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {
            errorMessage = "User is not logged in."
            return
        }

        guard let url = URL(string: "http://127.0.0.1:8080/api/users/\(uid)") else {
            errorMessage = "Invalid URL."
            return
        }
        
        URLSession.shared.dataTask(with: url){
            data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Fetch error : \(error.localizedDescription)"
                }
                return
            }
        
            
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            
            
            guard let data = data else {
                DispatchQueue.main.async {
                                self.errorMessage = "No data received"
                            }
                            return
            }
                        
  
            if let httpResponse = response as? HTTPURLResponse {
                print("📡 HTTP Status Code: \(httpResponse.statusCode)")
            }
            
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
                
                let decodedUser = try decoder.decode(User.self, from: data)
                DispatchQueue.main.async {
                    self.user = decodedUser
                }

            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
