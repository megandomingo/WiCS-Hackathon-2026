import SwiftUI

enum AccountTab: String, CaseIterable {
    case posts = "Posts"
    case achievements = "Achievements"
    case friends = "Friends"
}

struct AccountView: View {
    @State private var activeTab: AccountTab = .posts
    @State private var friends: [Friend] = MockData.mockFriends

    private let currentUser = MockData.currentUser
    private var userPosts: [Post] {
        MockData.mockPosts.filter { $0.userId == currentUser.id }
    }

    private func removeFriend(id: String) {
        friends.removeAll { $0.id == id }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Profile header
                    HStack(alignment: .top, spacing: 16) {
                        AsyncImage(
                            url: URL(string: currentUser.avatar),
                            content: { image in
                                image.resizable().scaledToFill()
                            },
                            placeholder: {
                                Color.gray.opacity(0.3)
                            }
                        )

                        .frame(width: 80, height: 80)
                        .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(currentUser.name)
                                    .font(.title2.bold())
                                Spacer()
                                Button { } label: {
                                    Image(systemName: "gearshape")
                                        .font(.title3)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            Text(currentUser.bio)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            HStack(spacing: 24) {
                                VStack(spacing: 2) {
                                    Text("\(userPosts.count)")
                                        .font(.headline)
                                    Text("Posts")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                VStack(spacing: 2) {
                                    Text("\(friends.count)")
                                        .font(.headline)
                                    Text("Friends")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                VStack(spacing: 2) {
                                    Text("\(currentUser.achievements.count)")
                                        .font(.headline)
                                    Text("Achievements")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }

                            HStack(spacing: 6) {
                                Image(systemName: "flame.fill")
                                    .foregroundStyle(.orange)
                                Text("\(currentUser.streak) Day Streak")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.orange)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.orange.opacity(0.2))
                            .clipShape(Capsule())
                        }
                    }
                    .padding()

                    // Tabs
                    Picker("Tab", selection: $activeTab) {
                        ForEach(AccountTab.allCases, id: \.self) { tab in
                            Text(tab.rawValue).tag(tab)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    // Content
                    SwiftUI.Group {
                        switch activeTab {
                        case .posts:
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 2) {
                                ForEach(userPosts) { post in
                                    if let url = post.images.first {
                                        AsyncImage(
                                            url: URL(string: url),
                                            content: { image in
                                                image.resizable().scaledToFill()
                                            },
                                            placeholder: {
                                                Color.gray.opacity(0.3)
                                            }
                                        )
                                        .aspectRatio(1, contentMode: .fill)
                                        .clipped()
                                    }
                                }
                            }
                            .padding(.top, 16)
                            if userPosts.isEmpty {
                                Text("No posts yet. Start sharing your cooking!")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 48)
                            }

                        case .achievements:
                            LazyVStack(spacing: 16) {
                                ForEach(currentUser.achievements) { achievement in
                                    HStack(spacing: 16) {
                                        Text(achievement.icon)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(achievement.title)
                                                .font(.headline)
                                            Text(achievement.description)
                                                .font(.subheadline)
                                                .foregroundStyle(.secondary)
                                            if let date = ISO8601DateFormatter().date(from: achievement.unlockedAt) {
                                                Text("Unlocked \(date.formatted(date: .abbreviated, time: .omitted))")
                                                    .font(.caption2)
                                                    .foregroundStyle(.secondary)
                                            }
                                        }
                                        Spacer()
                                        Image(systemName: "medal.fill")
                                            .foregroundStyle(.orange)
                                    }
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray4), lineWidth: 1))
                                }
                            }
                            .padding(.top, 16)

                        case .friends:
                            VStack(spacing: 16) {
                                Button { } label: {
                                    HStack {
                                        Image(systemName: "person.badge.plus")
                                        Text("Add Friends")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(Color.orange)
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }

                                ForEach(friends) { friend in
                                    HStack(spacing: 12) {
                                        AsyncImage(
                                            url: URL(string: friend.avatar),
                                            content: { image in
                                                image.resizable().scaledToFill()
                                            },
                                            placeholder: {
                                                Color.gray.opacity(0.3)
                                            }
                                        )
                                        .frame(width: 48, height: 48)
                                        .clipShape(Circle())

                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(friend.name)
                                                .font(.headline)
                                            Text(friend.status == .active ? "Friends" : "Pending")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                        Spacer()
                                        Button {
                                            removeFriend(id: friend.id)
                                        } label: {
                                            Image(systemName: "person.badge.minus")
                                                .font(.title3)
                                                .foregroundStyle(.red)
                                        }
                                    }
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray4), lineWidth: 1))
                                }
                            }
                            .padding(.top, 16)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AccountView()
}
