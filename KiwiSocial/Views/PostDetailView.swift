import SwiftUI

struct PostDetailView: View {
    let post: Post
    
    var body: some View {
        VStack(){
            Text(post.body)
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}
