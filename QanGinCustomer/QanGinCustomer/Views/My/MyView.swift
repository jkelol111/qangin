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
                    ScrollView {
                        LazyVStack {
                            ForEach(bookings) { booking in
                                BookingItemView(booking: booking)
                            }
                        }
                        .padding([.leading, .trailing])
                    }
                    
                }
            }
            .navigationTitle("My Flights")
            .navigationDestination(for: Booking.self) { booking in
                BookingConfirmationView(booking: booking, path: .constant([]), selectedTab: .constant(.mine))
            }
        }
    }
}

#Preview {
    MyView()
}
