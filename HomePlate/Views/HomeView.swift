import SwiftUI

struct HomeView: View {
    @State private var posts: [Post] = MockData.mockPosts
    private let currentUser = MockData.currentUser

    private func handleRate(postId: String, rating: Int) {
        guard let index = posts.firstIndex(where: { $0.id == postId }) else { return }
        if let ratingIndex = posts[index].ratings.firstIndex(where: { $0.userId == currentUser.id }) {
            posts[index].ratings[ratingIndex].rating = rating
        } else {
            posts[index].ratings.append(PostRating(userId: currentUser.id, rating: rating))
        }
    }

    private func handleComment(postId: String, text: String) {
        guard let index = posts.firstIndex(where: { $0.id == postId }) else { return }
        posts[index].comments.append(PostComment(
            userId: currentUser.id,
            userName: currentUser.name,
            text: text,
            createdAt: ISO8601DateFormatter().string(from: Date())
        ))
    }

    private func handleSave(postId: String) {
        guard let index = posts.firstIndex(where: { $0.id == postId }) else { return }
        if posts[index].saves.contains(currentUser.id) {
            posts[index].saves.removeAll { $0 == currentUser.id }
        } else {
            posts[index].saves.append(currentUser.id)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach($posts) { $post in
                        PostCardView(
                            post: $post,
                            onRate: { handleRate(postId: post.id, rating: $0) },
                            onComment: { handleComment(postId: post.id, text: $0) },
                            onSave: { handleSave(postId: post.id) },
                            currentUserId: currentUser.id
                        )
                    }
                }
                .padding()
                .padding(.bottom, 24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("HomePlate")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 6) {
                        Image(systemName: "flame.fill")
                            .foregroundStyle(.orange)
                        Text("\(currentUser.streak) day streak")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.orange)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.orange.opacity(0.2))
                    .clipShape(Capsule())
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
