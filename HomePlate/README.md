# HomePlate — SwiftUI

SwiftUI port of the **Home Cooking Social App** (React/TypeScript). Same features: home feed, cuisine map, share plate, groups, and account with posts/achievements/friends.

## Requirements

- Xcode 15+ (Swift 5.9+)
- iOS 17+ (for `PhotosPicker` and `ContentUnavailableView`)

## Setup in Xcode

1. **Create a new iOS App**
   - File → New → Project
   - Choose **App**
   - Product Name: `HomePlate`
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Storage: None
   - Include Tests: optional

2. **Add the source files**
   - Delete the default `ContentView.swift` if you want (the app uses `MainTabView` as root).
   - In the Project Navigator, right‑click the `HomePlate` group → **Add Files to "HomePlate"…**
   - Select the `HomePlate` folder (this repo’s `HomePlate` directory).
   - Check **Copy items if needed** and **Create groups**.
   - Ensure the **HomePlate** target is checked for all added files.

3. **Ensure app entry point**
   - The app entry is `HomePlateApp.swift` with `@main struct HomePlateApp`.
   - If Xcode created its own `@main` in another file, remove that file or remove `@main` from it so only `HomePlateApp` is the app entry.

4. **Run**
   - Select a simulator or device and run (⌘R).

## Project structure

```
HomePlate/
├── HomePlateApp.swift      # App entry, shows MainTabView
├── Models/
│   └── Models.swift        # Post, User, Achievement, Friend, Group
├── Data/
│   └── MockData.swift      # currentUser, mockPosts, mockFriends, mockGroups
└── Views/
    ├── MainTabView.swift   # Tab bar: Home, Map, Plate, Groups, Account
    ├── HomeView.swift      # Feed + streak header
    ├── PostCardView.swift  # Single post card (rate, comment, save)
    ├── CuisineMapView.swift # Cuisine stats and journey
    ├── PlateView.swift     # Share plate (photos, title, cuisine, recipe)
    ├── GroupsView.swift    # Groups list + create group sheet
    ├── AccountView.swift   # Profile, tabs: Posts / Achievements / Friends
    └── NotFoundView.swift  # 404-style view (for future use)
```

## Features

- **Home**: Feed of posts, streak badge, rate/comment/save on each post.
- **Map**: “Cuisine Map” — total dishes, favorite cuisine, and progress list by cuisine.
- **Plate**: Share a plate — photos (PhotosPicker), title, cuisine, description, optional recipe (link or custom text).
- **Groups**: List groups, create new group (name + description) in a sheet.
- **Account**: Profile header, stats, streak; tabs for Posts grid, Achievements, and Friends (with remove).

Mock data is in `MockData.swift`; replace with real API/store when you connect a backend.
