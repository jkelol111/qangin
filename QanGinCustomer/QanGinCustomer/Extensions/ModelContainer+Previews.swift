// Fix for Xcode Previews crashing issue

#if DEBUG
import SwiftData

@MainActor
extension ModelContainer {
    static func preview() -> ModelContainer {
        do {
            let modelContainer = try ModelContainer(
                for: Booking.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            return modelContainer
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
#endif
