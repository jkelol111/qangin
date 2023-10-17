import SwiftUI

struct RootView: View {
    @State private var flights: [Flight] = [
        Flight(
            id: "FS100",
            departingAirport: "SYD",
            departureDate: .now + 86400,
            arrivingAirport: "MEL",
            arrivalDate: .now + 90000,
            bookings: [
                Booking(id: "ABC123", passengers: 3, services: [.food, .drinks, .dutyFree]),
                Booking(id: "DEF456", passengers: 4, services: [.food]),
                Booking(id: "GHI789", passengers: 6, services: [.food, .drinks])
            ]
        ),
        Flight(
            id: "FS101",
            departingAirport: "SYD",
            departureDate: .now + 86400,
            arrivingAirport: "MEL",
            arrivalDate: .now + 90000,
            bookings: [
                Booking(id: "KJL123", passengers: 3, services: [.food, .drinks, .dutyFree]),
                Booking(id: "MNO456", passengers: 4, services: [.food]),
                Booking(id: "PQR789", passengers: 6, services: [.food, .drinks]),
                Booking(id: "STU012", passengers: 8, services: [.food, .dutyFree])
            ]
        )
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(flights) { flight in
                    NavigationLink(value: flight.isCancelled ? "" : flight.id) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(flight.id)
                                    .bold()
                                Text("\(flight.bookings.count) bookings")
                            }
                            Spacer()
                            
                        }
                        .strikethrough(flight.isCancelled, color: .red)
                        .foregroundStyle(flight.isCancelled ? .red : .white)
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            if let i = flights.firstIndex(of: flight) {
                                flights[i].isCancelled.toggle()
                            }
                        } label: {
                            if flight.isCancelled {
                                Label("Rebook", systemImage: "checkmark")
                            } else {
                                Label("Cancel flight", systemImage: "xmark")
                            }
                        }
                        .tint(flight.isCancelled ? .green : .red)
                    }
                }
            }
            .navigationTitle("Flights")
            .navigationDestination(for: Flight.ID.self) { id in
                if let i = flights.firstIndex(where: {$0.id == id}) {
                    BookingView(flight: $flights[i])
                } else {
                    ContentUnavailableView("Flight not found", systemImage: "xmark.octagon")
                }
            }
        }
    }
}

#Preview {
    RootView()
}
