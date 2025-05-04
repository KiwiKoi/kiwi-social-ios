//
//  HomeView.swift
//  KiwiSocial
//
//  Created by Daniel Visage on 13/04/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = PostViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                NavigationLink(destination:PostDetailView(post: post)) {
                    Text(post.body)
                        .font(.subheadline)
                }
            }
            .navigationTitle("Posts")
            .onAppear {
                viewModel.fetchPosts()
            }
        }
    }
}


#Preview {
    HomeView()
}
