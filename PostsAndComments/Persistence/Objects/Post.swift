//
//  Post.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright © 2019 cs. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Post: Object, Decodable {
    dynamic var id: Int
    dynamic var userId: Int
    dynamic var title: String
    dynamic var body: String

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
        case body
    }

    override static func primaryKey() -> String {
        return "id"
    }
}
