//
//  JsonplaceholderAPI.swift
//  PostsAndComments
//
//  Created by CS on 15/12/2019.
//  Copyright © 2019 CS. All rights reserved.
//

import Foundation


enum JsonplaceholderService {
    case posts
    case comments
}

extension JsonplaceholderService: Service {
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .comments:
            return "/comments"
        }
    }

    var parameters: [String: Any]? {
        // we don't have any parameters
        return nil
    }

    var method: ServiceMethod {
        return .get
    }
}
