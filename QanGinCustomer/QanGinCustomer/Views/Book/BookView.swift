import SwiftUI

struct BookView: View {
    enum Paths: Hashable {
        case destinationPicker(CityPicker.Direction)
        case flightSelection(FlightSelectionView.Direction)
        case passengers
        case confirm
    }
    
    @Binding var selectedTab: RootTabView.Tabs
    
    @State private var booking = Booking(
        id: "ABC123",
        to: .melbourne,
        flyingOn: .now + 86400,
        isBooked: false
    )
    @State private var adultsCount = 0
    @State private var childrenCount = 0
    @State private var path: [Paths] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    NavigationLink(value: Paths.destinationPicker(.from)) {
                        VStack(alignment: .leading) {
                            Text("From")
                                .fontWeight(.semibold)
                            Text(booking.from.rawValue)
                                .font(.title2.bold())
                        }
                        .shadow(radius: 30)
                    }
                    .foregroundStyle(.white)
                    .listRowBackground(
                        Image("Destinations/\(booking.from.rawValue)")
                            .resizable()
                            .scaledToFill()
                    )
                    NavigationLink(value: Paths.destinationPicker(.to)) {
                        VStack(alignment: .leading) {
                            Text("To")
                                .fontWeight(.semibold)
                            Text(booking.to.rawValue)
                                .font(.title2.bold())
                        }
                        .shadow(radius: 30)
                    }
                    .foregroundStyle(.white)
                    .listRowBackground(
                        Image("Destinations/\(booking.to.rawValue)")
                            .resizable()
                            .scaledToFill()
                    )
                }
                Section("Dates") {
                    DatePicker("Depart on", selection: $booking.flyingOn, displayedComponents: .date)
                    Toggle("Return?", isOn: $booking.isReturn.animation())
                        .onChange(of: booking.isReturn) { _, isReturn in
                            if !isReturn {
                                booking.returnFlight = nil
                            }
                        }
                    if booking.isReturn {
                        DatePicker("Return", selection: $booking.returningOn, displayedComponents: .date)
                    }
                }
                
                Section("Passengers") {
                    Stepper {
                        LabeledContent("Adults", value: String(adultsCount))
                    } onIncrement: {
                        booking.adults.append(.init(name: ""))
                        adultsCount += 1
                    } onDecrement: {
                        if adultsCount > 0 {
                            booking.adults.popLast()
                            adultsCount -= 1
                        }
                    }
                    
                    Stepper {
                        LabeledContent("Children", value: String(childrenCount))
                    } onIncrement: {
                        booking.children.append(.init(name: ""))
                        childrenCount += 1
                    } onDecrement: {
                        if childrenCount > 0 {
                            booking.children.popLast()
                            childrenCount -= 1
                        }
                    }
                }
                
                Button("Search flights") {
                    path.append(.flightSelection(.forward))
                }
                .buttonStyle(BigFriendlyButtonStyle())
                .listRowInsets(.none)
                .listRowSpacing(0)
                .listRowBackground(Color.clear)
                .disabled(adultsCount == 0 && childrenCount == 0)
            }
            .navigationTitle("Book")
            .navigationDestination(for: Paths.self) { path in
                switch path {
                case .destinationPicker(let direction):
                    CityPicker(direction: direction, booking: booking)
                case .flightSelection(let direction):
                    FlightSelectionView(direction: direction, booking: booking, path: $path)
                case .passengers:
                    PassengersInfoView(booking: booking, path: $path)
                case .confirm:
                    BookingConfirmationView(booking: booking, path: $path, selectedTab: $selectedTab)
                }
            }
            .onAppear {
                booking = Booking(
                    id: "ABC123",
                    to: .melbourne,
                    flyingOn: .now + 86400,
                    isBooked: false
                )
            }
        }
    }
}

//#Preview {
//    BookView()
//}
