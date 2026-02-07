import SwiftUI

struct NotFoundView: View {
    var body: some View {
        ContentUnavailableView {
            Label("Page not found", systemImage: "questionmark.circle")
        } description: {
            Text("The page you're looking for doesn't exist.")
        } actions: {
            // Caller can wrap in NavigationStack and present this; no built-in "Go Home" without navigation context.
        }
    }
}

#Preview {
    NotFoundView()
}
