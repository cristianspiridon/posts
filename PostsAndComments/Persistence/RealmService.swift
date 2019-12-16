import Foundation
import RealmSwift

// swiftlint:disable force_try
// swiftlint:disable statement_position

extension Realm {
    public func safeWrite(_ block: () throws -> Void) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}

class RealmService {
    private init() {}

    public static let shared = RealmService()

    var userProvider = RealmProvider.lenny

    func addPosts(_ posts: [Post]) {
        for post in posts {
            userProvider.create(post)
        }
    }

    func addComments(_ comments: [Comment]) {
        for comment in comments {
            userProvider.create(comment)
        }
    }

    func getAllPosts() -> [Post] {
        let posts = userProvider.realm.objects(Post.self)
        return Array(posts)
    }

    func getAllComments(by postId: Int) -> [Comment] {
        let comments = userProvider.realm.objects(Comment.self).filter { (comment) -> Bool in
            comment.postId == postId
        }
        return Array(comments)
    }

    func getNumberOfCommentOn(_ postId: Int) -> Int {
        return getAllComments(by: postId).count
    }

    func deleteAll() {
        userProvider.deleteAll()
    }
}
