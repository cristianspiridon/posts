//
//  AdorableAvatarsAPI.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright © 2019 cs. All rights reserved.
//

import Foundation

enum AdorableAvatarsAPI {
    case avatars(name: String)
}

extension AdorableAvatarsAPI: Service {
    var baseURL: String {
        return "https://api.adorable.io"
    }

    var path: String {
        switch self {
        case let .avatars(name):
            return "/avatars/100/\(name).png"
        }
    }

    var parameters: [String: Any]? {
        // we don't have any parameters in our calls for this demo
        return nil
    }

    var method: ServiceMethod {
        return .get
    }
}
