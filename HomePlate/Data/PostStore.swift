import Foundation

@MainActor
final class PostStore: ObservableObject {
    @Published var posts: [Post] = []

    func addPost(_ post: Post) {
        posts.insert(post, at: 0)
    }
}
