import SwiftUI
import SwiftData

struct MyView: View {
    @Query private var bookings: [Booking]
    
    var body: some View {
        NavigationStack {
            Group {
                if bookings.isEmpty {
                    ContentUnavailableView("No booked flights", systemImage: "airplane.departure", description: Text("Book a flight first, then you can find it here"))
                } else {
                    LazyVStack {
                        ForEach(bookings) { booking in
                            
                        }
                    }
                }
            }
            .navigationTitle("My Flights")
        }
    }
}

#Preview {
    MyView()
}
