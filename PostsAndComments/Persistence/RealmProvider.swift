import Foundation
import RealmSwift

// swiftlint:disable force_try
// swiftformat:disable statement_position

class RealmProvider {
    let configuration: Realm.Configuration

    internal init(config: Realm.Configuration) {
        configuration = config
    }

    var realm: Realm {
        return try! Realm(configuration: configuration)
    }

    // MARK: - User realm

    private static let lennyConfig = Realm.Configuration(
        fileURL: try! Path.inLibrary("lenny.realm"),
        schemaVersion: 1,
        deleteRealmIfMigrationNeeded: true,
        objectTypes: [Post.self,
                      Comment.self]
    )

    public static var lenny: RealmProvider = {
        RealmProvider(config: lennyConfig)
    }()

    func appendList<T: Object>(_ list: List<T>, _ object: T) {
        do {
            try realm.safeWrite {
                list.append(object)
            }
        } catch {
            post(error)
        }
    }

    // MARK: CRUD without read

    func create<T: Object>(_ object: T) {
        do {
            try realm.safeWrite {
                realm.add(object, update: true)
            }
        } catch {
            post(error)
        }
    }

    func update<T: Object>(_ object: T, with dict: [String: Any]) {
        do {
            try realm.safeWrite {
                for (key, value) in dict {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }

    func delete<T: Object>(_ object: T) {
        do {
            try realm.safeWrite {
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }

    func deleteAll() {
        do {
            try realm.safeWrite {
                realm.deleteAll()
            }
        } catch {
            post(error)
        }
    }

    func post(_ error: Error) {
        NotificationCenter.default.post(name: Notification.Name("RealmError"), object: error)
    }

    func observeRealmError(in _: UIViewController, completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RealmError"), object: nil, queue: nil) { notification in
            completion(notification.object as? Error)
        }
    }

    func stopObservingError(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }
}

private let groupId = "group.com.cs.cs"

enum PathError: Error, LocalizedError {
    case notFound
    case containerNotFound(String)

    var errorDescription: String? {
        switch self {
        case .notFound: return "Resource not found"
        case let .containerNotFound(id): return "Shared container for group \(id) not found"
        }
    }
}

class Path {
    static func inLibrary(_ name: String) throws -> URL {
        return try FileManager.default
            .url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(name)
    }

    static func inDocuments(_ name: String) throws -> URL {
        return try FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(name)
    }

    static func inBundle(_ name: String) throws -> URL {
        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
            throw PathError.notFound
        }
        return url
    }

    static func inSharedContainer(_ name: String) throws -> URL {
        guard let url = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: groupId) else {
            throw PathError.containerNotFound(groupId)
        }
        return url.appendingPathComponent(name)
    }

    static func documents() throws -> URL {
        return try FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
}
