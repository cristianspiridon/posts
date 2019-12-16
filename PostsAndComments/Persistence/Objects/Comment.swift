//
//  Comment.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright © 2019 cs. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Comment: Object, Decodable {
    dynamic var id: Int
    dynamic var postId: Int
    dynamic var name: String
    dynamic var email: String
    dynamic var body: String

    enum CodingKeys: String, CodingKey {
        case id
        case postId
        case name
        case email
        case body
    }

    override static func primaryKey() -> String {
        return "id"
    }
}
