import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = PostViewModel()
    
    @State private var isPresentingNewPostForm = false

    var body: some View {
            VStack{
                List(viewModel.posts) { post in
                    NavigationLink(destination:PostDetailView(post: post)) {
                        Text(post.body)
                            .font(.subheadline)
                    }
                  
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isPresentingNewPostForm = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
       
            .navigationTitle("Posts")
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


#Preview {
    HomeView()
}
