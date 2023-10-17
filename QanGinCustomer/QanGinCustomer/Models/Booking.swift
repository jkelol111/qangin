import SwiftData
import Foundation

@Model
final class Booking: Identifiable {
    struct Passenger: Identifiable, Codable {
        struct Seat: Codable, Equatable {
            var row: Int
            var position: String
            var price: Double = 250.0
            
            var string: String {
                "\(row + 1)\(position)"
            }
        }
        
        enum Services: String, Codable {
            case food = "Food"
            case drinks = "Drinks"
            case dutyFree = "Duty-free"
            
            var icon: String {
                switch self {
                case .food:
                    "fork.knife"
                case .drinks:
                    "wineglass"
                case .dutyFree:
                    "handbag"
                }
            }
            
            var price: Double {
                switch self {
                case .food:
                    27.99
                case .drinks:
                    9.99
                case .dutyFree:
                    199.99
                }
            }
        }

        var id = UUID()
        var name: String
        var passport: String
        var seat: Seat?
        var services: [Services: Int]
        
        init(name: String = "", passport: String = "", seat: Seat? = nil, services: [Services: Int] = [:]) {
            self.name = name
            self.passport = passport
            self.seat = seat
            self.services = services
        }
    }
    
    struct Flight: Codable, Identifiable {
        let id: String
        let flyingOn: Date
    }

    @Attribute(.unique)
    var id: String
    var bookedOn: Date
    
    var from: Destinations
    var to: Destinations
    
    @Attribute(.ephemeral)
    var flyingOn = Date.now
    var forwardFlight: Flight?
    @Attribute(.ephemeral)
    var isReturn = true
    @Attribute(.ephemeral)
    var returningOn = Date.now + 86400
    var returnFlight: Flight?
    
    var adults: [Passenger]
    var children: [Passenger]
    
    @Attribute(.ephemeral)
    var isBooked = true
    
    init(id: String, to: Destinations, flyingOn: Date, forwardFlight: Flight? = nil, returnFlight: Flight? = nil, adults: [Passenger] = [], children: [Passenger] = [], isBooked: Bool = true) {
        self.id = id
        self.bookedOn = .now
        self.from = .sydney
        self.to = to
        self.flyingOn = flyingOn
        self.forwardFlight = forwardFlight
        self.returnFlight = returnFlight
        self.adults = adults
        self.children = children
        self.isBooked = isBooked
    }
    
    func totalPassengers() -> Int {
        return adults.count + children.count
    }
    
    func subtotal() -> Double {
        var t = 0.0
        for adult in adults {
            t += adult.seat?.price ?? 0.0
            for service in adult.services.keys {
                t += service.price * Double(adult.services[service]!)
            }
        }
        for child in children {
            t += child.seat?.price ?? 0.0
            for service in child.services.keys {
                t += service.price * Double(child.services[service]!)
            }
        }
        return t
    }
}
