import SwiftUI
import UIKit

struct PostCardView: View {
    @Binding var post: Post
    let onRate: (Int) -> Void
    let onComment: (String) -> Void
    let onSave: () -> Void
    let currentUserId: String

    @State private var showComments = false
    @State private var commentText = ""
    @State private var showRecipe = false

    private var avgRating: Double {
        guard !post.ratings.isEmpty else { return 0 }
        return Double(post.ratings.map(\.rating).reduce(0, +)) / Double(post.ratings.count)
    }

    private var userRating: Int {
        post.ratings.first(where: { $0.userId == currentUserId })?.rating ?? 0
    }

    private var isSaved: Bool {
        post.saves.contains(currentUserId)
    }

    private func formatDate(_ dateString: String) -> String {
        guard let date = ISO8601DateFormatter().date(from: dateString) else { return dateString }
        let hours = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour ?? 0
        if hours < 1 { return "Just now" }
        if hours < 24 { return "\(hours)h ago" }
        return "\(hours / 24)d ago"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // User info
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: post.userAvatar)) { image in
                    image.resizable().scaledToFill()
                } placeholder: { Color.gray.opacity(0.3) }
                .frame(width: 40, height: 40)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 2) {
                    Text(post.userName)
                        .font(.subheadline.weight(.semibold))
                    Text(formatDate(post.createdAt))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text(post.cuisine)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.orange)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.orange.opacity(0.2))
                    .clipShape(Capsule())
            }
            .padding()

            // Image
            if let firstImage = post.images.first, let uiImage = UIImage(data: firstImage.data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 280)
                    .clipped()
            } else {
                Color.gray.opacity(0.3)
                    .frame(height: 280)
            }

            // Content
            VStack(alignment: .leading, spacing: 12) {
                Text(post.title)
                    .font(.headline)
                Text(post.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                // Recipe link / custom recipe
                if post.recipeLink != nil || post.customRecipe != nil {
                    VStack(alignment: .leading, spacing: 8) {
                        if let link = post.recipeLink, let url = URL(string: link) {
                            Link(destination: url) {
                                HStack(spacing: 4) {
                                    Image(systemName: "arrow.up.right.square")
                                    Text("View Recipe")
                                }
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(.orange)
                            }
                        }
                        if let custom = post.customRecipe {
                            Button {
                                showRecipe.toggle()
                            } label: {
                                (Text(showRecipe ? "Hide" : "Show") + Text(" Recipe"))
                                    .font(.subheadline.weight(.medium))
                                    .foregroundStyle(.orange)
                            }
                            if showRecipe {
                                Text(custom)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                }

                // Stats
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text(avgRating > 0 ? String(format: "%.1f", avgRating) : "No ratings")
                            .font(.caption)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("\(post.comments.count)")
                            .font(.caption)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "bookmark")
                        Text("\(post.saves.count)")
                            .font(.caption)
                    }
                }
                .foregroundStyle(.secondary)

                // Rate
                HStack(spacing: 8) {
                    Text("Rate this:")
                        .font(.subheadline.weight(.medium))
                    ForEach(1...5, id: \.self) { rating in
                        Button {
                            onRate(rating)
                        } label: {
                            Image(systemName: rating <= userRating ? "star.fill" : "star")
                                .font(.title2)
                                .foregroundStyle(rating <= userRating ? .yellow : .gray.opacity(0.4))
                        }
                        .buttonStyle(.plain)
                    }
                }

                // Actions
                HStack(spacing: 8) {
                    Button {
                        showComments.toggle()
                    } label: {
                        Text("Comment")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color(.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .foregroundStyle(.primary)

                    Button {
                        onSave()
                    } label: {
                        Text(isSaved ? "Saved" : "Save")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(isSaved ? Color.orange.opacity(0.2) : Color(.systemGray5))
                            .foregroundStyle(isSaved ? .orange : .primary)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }

                // Comments
                if showComments {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(post.comments) { comment in
                            VStack(alignment: .leading, spacing: 2) {
                                HStack {
                                    Text(comment.userName)
                                        .font(.subheadline.weight(.semibold))
                                    Text(comment.text)
                                        .font(.subheadline)
                                }
                                Text(formatDate(comment.createdAt))
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        HStack(spacing: 8) {
                            TextField("Add a comment...", text: $commentText)
                                .textFieldStyle(.roundedBorder)
                            Button("Post") {
                                if !commentText.isEmpty {
                                    onComment(commentText)
                                    commentText = ""
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray4), lineWidth: 1))
    }
}
