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
            }
            .onAppear {
                viewModel.fetchPosts()
            }
            .sheet(isPresented: $isPresentingNewPostForm) {
                 NewPostView {
                     // ✅ Refresh posts after new post is created
                     viewModel.fetchPosts()
                 }
             }
        }
    }
}


#Preview {
    HomeView()
}
