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

    static var mockPosts: [Post] {
        [
            Post(
                id: "post-1",
                userId: "user-1",
                userName: "You",
                userAvatar: currentUser.avatar,
                images: ["https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800&h=800&fit=crop"],
                cuisine: "Japanese",
                title: "Homemade Sushi Rolls",
                description: "First time making sushi at home! The rice was a bit tricky but turned out great. Used fresh salmon and avocado.",
                recipeLink: "https://example.com/sushi-recipe",
                createdAt: "2026-02-07T10:30:00Z",
                ratings: [
                    PostRating(userId: "user-2", rating: 5),
                    PostRating(userId: "user-3", rating: 4)
                ],
                comments: [
                    PostComment(userId: "user-2", userName: "Sarah Chen", text: "Looks amazing! I need to try this 😍", createdAt: "2026-02-07T11:00:00Z")
                ],
                saves: ["user-2", "user-3"]
            ),
            Post(
                id: "post-2",
                userId: "user-2",
                userName: "Sarah Chen",
                userAvatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400&h=400&fit=crop",
                images: ["https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800&h=800&fit=crop"],
                cuisine: "Italian",
                title: "Homemade Pasta Carbonara",
                description: "Classic carbonara with guanciale and pecorino romano. The key is to work quickly so the eggs don't scramble!",
                customRecipe: "1. Cook pasta\n2. Crisp guanciale\n3. Mix eggs and cheese\n4. Combine everything off heat",
                createdAt: "2026-02-06T19:15:00Z",
                ratings: [
                    PostRating(userId: "user-1", rating: 5),
                    PostRating(userId: "user-3", rating: 5),
                    PostRating(userId: "user-4", rating: 4)
                ],
                comments: [
                    PostComment(userId: "user-1", userName: "You", text: "Perfect! Love a good carbonara", createdAt: "2026-02-06T19:30:00Z"),
                    PostComment(userId: "user-4", userName: "Mike Johnson", text: "Technique looks spot on 👌", createdAt: "2026-02-06T20:00:00Z")
                ],
                saves: ["user-1"]
            ),
            Post(
                id: "post-3",
                userId: "user-3",
                userName: "Alex Rivera",
                userAvatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop",
                images: ["https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=800&h=800&fit=crop"],
                cuisine: "Mexican",
                title: "Tacos Al Pastor",
                description: "Marinated pork with pineapple, onions, and cilantro. Made my own tortillas from scratch too!",
                createdAt: "2026-02-06T13:45:00Z",
                ratings: [
                    PostRating(userId: "user-1", rating: 5),
                    PostRating(userId: "user-2", rating: 5)
                ],
                comments: [],
                saves: ["user-1", "user-2", "user-4"]
            ),
            Post(
                id: "post-4",
                userId: "user-4",
                userName: "Mike Johnson",
                userAvatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&h=400&fit=crop",
                images: ["https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=800&h=800&fit=crop"],
                cuisine: "Thai",
                title: "Pad Thai with Shrimp",
                description: "Authentic pad thai with tamarind paste, fish sauce, and fresh lime. The perfect balance of sweet, sour, and savory!",
                recipeLink: "https://example.com/pad-thai",
                createdAt: "2026-02-05T18:20:00Z",
                ratings: [PostRating(userId: "user-2", rating: 4)],
                comments: [
                    PostComment(userId: "user-2", userName: "Sarah Chen", text: "Where did you get tamarind paste?", createdAt: "2026-02-05T18:45:00Z")
                ],
                saves: []
            )
        ]
    }

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
