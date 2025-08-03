import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isLoggedIn: Bool = Auth.auth().currentUser != nil

    var body: some View {
        NavigationStack {
            if isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
