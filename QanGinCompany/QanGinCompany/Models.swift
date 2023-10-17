import Foundation

enum Service: String, Codable {
    case food = "fork.knife"
    case drinks = "wineglass.fill"
    case dutyFree = "handbag.fill"
}

struct Booking: Identifiable, Codable, Hashable {
    let id: String
    let passengers: Int
    let services: [Service]
    var isCancelled = false
}

struct Flight: Identifiable, Codable, Hashable {
    let id: String
    let departingAirport: String
    let departureDate: Date
    let arrivingAirport: String
    let arrivalDate: Date
    var aircraft: String = "Airbus A320-200"
    var bookings: [Booking]
    var isCancelled = false
}
