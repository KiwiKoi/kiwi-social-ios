import SwiftUI

struct PostDetailView: View {
    let post: Post
    
    var body: some View {
        ScrollView{
                VStack(alignment: .leading, spacing: 8){
                    Text(post.author.username)
                        .font(.caption)
                    Text(post.createdAt.formatted())
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text(post.body)
                        .font(.body)
                    Spacer()
                }
                .padding()
            
            CommentSectionView(postId: post.id)
        }
        .navigationTitle("Details")
    }
}
