import SwiftUI

struct RootTabView: View {
    enum Tabs: Int {
        case book
        case mine
        case alerts
    }
    
    @State private var isWelcomePresented = true
    @State private var selectedTab = Tabs.book
    
    var body: some View {
        TabView(selection: $selectedTab) {
            BookView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Book", systemImage: "airplane")
                }
                .tag(Tabs.book)
            MyView()
                .tabItem {
                    Label("My Flights", systemImage: "ticket")
                }
                .tag(Tabs.mine)
            AlertsView()
                .tabItem {
                    Label("Alerts", systemImage: "bell")
                }
                .badge(3)
                .tag(Tabs.alerts)
        }
        .fullScreenCover(isPresented: $isWelcomePresented) {
            WelcomeView()
        }
    }
}

#Preview {
    RootTabView()
}
