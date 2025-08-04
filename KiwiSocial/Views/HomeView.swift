import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = PostViewModel()
    
    @State private var isPresentingNewPostForm = false

    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                NavigationLink(destination:PostDetailView(post: post)) {
                    Text(post.body)
                        .font(.subheadline)
                }
            }
            .navigationTitle("Posts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingNewPostForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: DashboardView()) {
                        Image(systemName: "person.circle")
                    }
                }
            }
            .onAppear {
                viewModel.fetchPosts()
            }
            .sheet(isPresented: $isPresentingNewPostForm) {
                 NewPostView {
                     viewModel.fetchPosts()
                 }
             }
        }
    }
}


#Preview {
    HomeView()
}
