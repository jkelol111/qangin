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
        
        enum Services: Codable {
            case food
            case drink
            case dutyFree
            
            var icon: String {
                switch self {
                case .food:
                    "fork.knife"
                case .drink:
                    "wineglass"
                case .dutyFree:
                    "handbag"
                }
            }
            
            var price: Double {
                switch self {
                case .food:
                    27.99
                case .drink:
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

    @Attribute(.unique)
    var id: String
    var bookedOn: Date
    
    var from: Destinations
    var to: Destinations
    var flyingOn: Date
    var aircraft: String?
    
    var adults: [Passenger]
    var children: [Passenger]
    
    @Transient
    var isReturn = true
    @Transient
    var returnOn: Date = .now + 86400
    
    init(id: String, to: Destinations, flyingOn: Date, aircraft: String? = nil, adults: [Passenger] = [], children: [Passenger] = []) {
        self.id = id
        self.bookedOn = .now
        self.from = .sydney
        self.to = to
        self.flyingOn = flyingOn
        self.aircraft = aircraft
        self.adults = adults
        self.children = children
    }
}
