import Foundation

extension Booking {
    static func preview() -> Booking {
        return Booking(
            id: "ABC123",
            to: .sydney,
            flyingOn: .now + 84600,
            adults: [
                Passenger(name: "Ryan Gosling"),
                Passenger(name: "Margot Robbie")
            ],
            children: [
                Passenger(name: "Barbie")
            ]
        )
    }
}

extension Booking.Passenger {
    var preview: Booking.Passenger {
        Booking.Passenger(
            name: "Ryan Gosling",
            passport: "K3N0UGH",
            seat: Seat(row: 16, position: "F"),
            services: [
                .food: 1
            ]
        )
    }
}
