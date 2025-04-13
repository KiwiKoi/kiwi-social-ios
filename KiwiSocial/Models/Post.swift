//
//  Post.swift
//  KiwiSocial
//
//  Created by Daniel Visage on 13/04/2025.
//

import Foundation

struct Post: Identifiable, Decodable {
    let id: String
    let body: String
    let createdAt: Date
    let updatedAt: Date?
    let authorId: String
    let published: Bool
}
