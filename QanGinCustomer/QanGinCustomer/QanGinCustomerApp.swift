import SwiftUI
import SwiftData

@main
struct QanGinCustomerApp: App {
    private let container = try! ModelContainer(for: Booking.self)
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .modelContainer(container)
        }
    }
}
