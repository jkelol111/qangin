import SwiftUI

struct RootTabView: View {
    @State private var isWelcomePresented = true
    
    var body: some View {
        TabView {
            BookView()
                .tabItem {
                    Label("Book", systemImage: "airplane")
                }
            MyView()
                .tabItem {
                    Label("My Flights", systemImage: "ticket")
                }
            AlertsView()
                .tabItem {
                    Label("Alerts", systemImage: "bell")
                }
                .badge(3)
        }
        .fullScreenCover(isPresented: $isWelcomePresented) {
            WelcomeView()
        }
    }
}

#Preview {
    RootTabView()
}
