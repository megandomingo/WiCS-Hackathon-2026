import Foundation

struct Post: Identifiable {
    let id: String
    var userId: String
    var userName: String
    var userAvatar: String
    var images: [String]
    var cuisine: String
    var title: String
    var description: String
    var recipeLink: String?
    var customRecipe: String?
    var createdAt: String
    var ratings: [PostRating]
    var comments: [PostComment]
    var saves: [String]
}

struct PostRating: Identifiable {
    var id: String { userId }
    let userId: String
    var rating: Int
}

struct PostComment: Identifiable {
    let id = UUID()
    let userId: String
    let userName: String
    let text: String
    let createdAt: String
}

struct User: Identifiable {
    let id: String
    var name: String
    var avatar: String
    var bio: String
    var streak: Int
    var achievements: [Achievement]
    var cuisinesCookedCount: [String: Int]
}

struct Achievement: Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
    let unlockedAt: String
}

struct Friend: Identifiable {
    let id: String
    var name: String
    var avatar: String
    var status: FriendStatus
}

enum FriendStatus: String, CaseIterable {
    case active
    case pending
    case requested
}

struct Group: Identifiable {
    let id: String
    var name: String
    var members: [String]
    var avatar: String
    var description: String
}
