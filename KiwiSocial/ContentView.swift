import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isLoggedIn: Bool = Auth.auth().currentUser != nil
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
                Group {
                    if authViewModel.isLoggedIn {
                        MainTabView()
                    } else {
                        LoginView()
                    }
                }
                .environmentObject(authViewModel)
    }
}

#Preview {
    ContentView()
}
