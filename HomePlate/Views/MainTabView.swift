import SwiftUI

enum Tab: Int, CaseIterable {
    case home = 0
    case map
    case plate
    case groups
    case account
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)

            NotFoundView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
                .tag(Tab.map)

            PlateView()
                .tabItem {
                    Label("Plate", systemImage: "plus.circle.fill")
                }
                .tag(Tab.plate)

            NotFoundView()
                .tabItem {
                    Label("Groups", systemImage: "person.3.fill")
                }
                .tag(Tab.groups)

            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.circle.fill")
                }
                .tag(Tab.account)
        }
        .tint(Color.orange)
    }
}

#Preview {
    MainTabView()
}
