import SwiftUI

struct GroupsView: View {
    @State private var groups: [Group] = MockData.mockGroups
    @State private var showCreateModal = false
    @State private var newGroupName = ""
    @State private var newGroupDescription = ""

    private func createGroup() {
        guard !newGroupName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let newGroup = Group(
            id: "group-\(Int(Date().timeIntervalSince1970))",
            name: newGroupName,
            members: ["user-1"],
            avatar: "https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400&h=400&fit=crop",
            description: newGroupDescription
        )
        groups.append(newGroup)
        newGroupName = ""
        newGroupDescription = ""
        showCreateModal = false
    }

    var body: some View {
        NavigationStack {
            Group {
                if groups.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "person.3")
                            .font(.system(size: 48))
                            .foregroundStyle(Color(.systemGray3))
                        Text("No groups yet")
                            .font(.headline)
                        Text("Create a group to cook and share meals with friends!")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                        Button {
                            showCreateModal = true
                        } label: {
                            Text("Create Your First Group")
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(Color.orange)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(groups) { group in
                                HStack(spacing: 16) {
                                    AsyncImage(url: URL(string: group.avatar)) { image in
                                        image.resizable().scaledToFill()
                                    } placeholder: { Color.gray.opacity(0.3) }
                                    .frame(width: 64, height: 64)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(group.name)
                                            .font(.headline)
                                        Text(group.description)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        HStack(spacing: 4) {
                                            Image(systemName: "person.3")
                                                .font(.caption)
                                            Text("\(group.members.count) members")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    Spacer()
                                    Button { } label: {
                                        Image(systemName: "person.badge.plus")
                                            .font(.title3)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray4), lineWidth: 1))
                            }
                        }
                        .padding()
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Groups")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCreateModal = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.white)
                            .frame(width: 36, height: 36)
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 2) {
                        Text("Groups")
                        Text("Cook and share with your groups")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .sheet(isPresented: $showCreateModal) {
                NavigationStack {
                    Form {
                        Section {
                            TextField("e.g., Taco Tuesdays", text: $newGroupName)
                            TextField("What's this group about?", text: $newGroupDescription, axis: .vertical)
                                .lineLimit(3...6)
                        }
                    }
                    .navigationTitle("Create New Group")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showCreateModal = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Create") {
                                createGroup()
                            }
                            .fontWeight(.semibold)
                            .foregroundStyle(.orange)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GroupsView()
}
