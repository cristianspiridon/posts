//
//  AdorableAPIWorker.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright © 2019 cs. All rights reserved.
//

import Foundation
import PromiseKit

let imageCache = NSCache<NSString, UIImage>()

class AdorableAPIWorker {
    let provider = ServiceProvider<AdorableAvatarsAPI>()

    func loadAvatarImage(with email: String, completion: @escaping (UIImage) -> Void) {
        if let imageFromCache = cachedImage(for: email) {
            completion(imageFromCache)
            return
        }

        let service = AdorableAvatarsAPI.avatars(name: email)
        provider.call(service.urlRequest) { result in
            switch result {
            case let .success(data):
                if let image = UIImage(data: data) {
                    self.setCache(image: image, key: email)
                    completion(image)
                }
            case let .failure(error):
                print(error)
            case .empty:
                print("no data")
            }
        }
    }

    func cachedImage(for key: String) -> UIImage? {
        return imageCache.object(forKey: key as! NSString)
    }

    func setCache(image: UIImage, key: String) {
        imageCache.setObject(image, forKey: key as! NSString)
    }
}
