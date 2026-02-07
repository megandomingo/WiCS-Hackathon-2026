import SwiftUI

private let cuisineEmoji: [String: String] = [
    "Italian": "🇮🇹", "Japanese": "🇯🇵", "Mexican": "🇲🇽", "Thai": "🇹🇭",
    "Indian": "🇮🇳", "French": "🇫🇷", "Chinese": "🇨🇳", "Mediterranean": "🌊"
]

struct CuisineMapView: View {
    private let currentUser = MockData.currentUser
    private var cuisines: [(cuisine: String, count: Int)] {
        currentUser.cuisinesCookedCount
            .map { ($0.key, $0.value) }
            .sorted { $0.count > $1.count }
    }
    private var maxCount: Int {
        currentUser.cuisinesCookedCount.values.max() ?? 1
    }
    private var totalDishes: Int {
        currentUser.cuisinesCookedCount.values.reduce(0, +)
    }

    private func emoji(for cuisine: String) -> String {
        cuisineEmoji[cuisine] ?? "🍽️"
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Summary card
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 12) {
                            Image(systemName: "fork.knife")
                                .font(.title)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\(totalDishes)")
                                    .font(.title2.bold())
                                Text("Total dishes cooked")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.9))
                            }
                        }
                        if let first = cuisines.first {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Favorite Cuisine")
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.9))
                                    Text(first.0)
                                        .font(.headline)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("Times Cooked")
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.9))
                                    Text("\(first.1)")
                                        .font(.headline)
                                }
                            }
                        }
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    // Cuisine list
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Your Cooking Journey")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Divider()
                        ForEach(cuisines, id: \.cuisine) { item in
                            let cuisine = item.cuisine
                            let count = item.count

                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(emoji(for: cuisine))
                                        .font(.title2)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(cuisine)
                                            .font(.subheadline.weight(.semibold))
                                        Text("\(count) dishes")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Text("\(Int((Double(count) / Double(maxCount)) * 100))%")
                                        .font(.caption.weight(.medium))
                                        .foregroundStyle(.orange)
                                }
                                GeometryReader { geo in
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color(.systemGray5))
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(
                                                LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing)
                                            )
                                        let progress = geo.size.width * CGFloat(count) / CGFloat(maxCount)

                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(
                                                LinearGradient(
                                                    colors: [.orange, .red],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                            .frame(width: progress)

                                    }
                                }
                                .frame(height: 8)
                            }
                            .padding()
                            if cuisine != cuisines.last?.0 {
                                Divider()
                                    .padding(.leading)
                            }
                        }
                    }
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray4), lineWidth: 1))

                    // Unlock more
                    VStack(spacing: 8) {
                        Text("🌍")
                            .font(.title)
                        Text("Explore More Cuisines")
                            .font(.headline)
                        Text("Try cooking from different cultures to expand your map!")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(24)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray4), lineWidth: 1))
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Cuisine Map")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 2) {
                        Text("Cuisine Map")
                        Text("You've explored \(cuisines.count) different cuisines!")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    CuisineMapView()
}
