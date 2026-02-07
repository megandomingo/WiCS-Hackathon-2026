import Foundation

enum MockData {
    static let currentUser = User(
        id: "user-1",
        name: "You",
        avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&h=400&fit=crop",
        bio: "Home cook 🍳 | Trying new recipes every week",
        streak: 7,
        achievements: [
            Achievement(id: "ach-1", title: "First Sushi!", description: "Made your first sushi meal", icon: "🍣", unlockedAt: "2026-02-01T12:00:00Z"),
            Achievement(id: "ach-2", title: "Week Warrior", description: "Posted meals for 7 days straight", icon: "🔥", unlockedAt: "2026-02-07T12:00:00Z"),
            Achievement(id: "ach-3", title: "Italian Master", description: "Cooked 10 Italian dishes", icon: "🇮🇹", unlockedAt: "2026-01-28T12:00:00Z")
        ],
        cuisinesCookedCount: [
            "Italian": 12, "Japanese": 8, "Mexican": 6, "Thai": 5, "Indian": 4,
            "French": 3, "Chinese": 7, "Mediterranean": 4
        ]
    )

    static var mockFriends: [Friend] {
        [
            Friend(id: "user-2", name: "Sarah Chen", avatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400&h=400&fit=crop", status: .active),
            Friend(id: "user-3", name: "Alex Rivera", avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop", status: .active),
            Friend(id: "user-4", name: "Mike Johnson", avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&h=400&fit=crop", status: .active)
        ]
    }

    static var mockGroups: [Group] {
        [
            Group(id: "group-1", name: "Weekend Warriors", members: ["user-1", "user-2", "user-3"], avatar: "https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400&h=400&fit=crop", description: "Cooking together every Sunday!"),
            Group(id: "group-2", name: "Asian Cuisine Club", members: ["user-1", "user-2", "user-4"], avatar: "https://images.unsplash.com/photo-1512058564366-18510be2db19?w=400&h=400&fit=crop", description: "Exploring Asian flavors")
        ]
    }
}
