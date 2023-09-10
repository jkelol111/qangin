import SwiftUI

struct BookView: View {
    enum BookPaths: Hashable {
        case fromPicker
        case toPicker
        case flightSelection
        case passengers
        case confirm
    }
    
    @State private var booking = Booking(
        id: "ABC123",
        to: .melbourne,
        flyingOn: .now + 86400
    )
    @State private var adultsCount = 0
    @State private var childrenCount = 0
    @State private var path: [BookPaths] = []
    
    @ViewBuilder
    private func pickerItem(_ destination: Destinations) -> some View {
        Text(destination.rawValue)
            .font(.title.weight(.semibold))
            .padding()
            .listRowBackground(Image("Destination/\(destination.rawValue)")
                .resizable()
                .scaledToFill())
            .background {
                Image("Destination/\(destination.rawValue)")
                    .resizable()
                    .scaledToFill()
            }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    NavigationLink(value: BookPaths.fromPicker) {
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
                    NavigationLink(value: BookPaths.toPicker) {
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
                    HStack {
                        VStack(spacing: 8) {
                            Image(systemName: "airplane.departure")
                            DatePicker("Depart", selection: $booking.flyingOn, displayedComponents: .date)
                                .labelsHidden()
                        }
                        Divider()
                        VStack(spacing: 12) {
                            Image(systemName: "arrowshape.left.arrowshape.right.fill")
                            Toggle("Book return", isOn: $booking.isReturn)
                                .labelsHidden()
                        }
                        if booking.isReturn {
                            Divider()
                            VStack(spacing: 8) {
                                Image(systemName: "airplane.arrival")
                                DatePicker("Return", selection: $booking.returnOn, displayedComponents: .date)
                                    .labelsHidden()
                            }
                        }
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
                            booking.adults.removeLast()
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
                            booking.children.removeLast()
                            childrenCount -= 1
                        }
                    }
                }
                
                Button("Search flights") {
                    path.append(.flightSelection)
                }
                .buttonStyle(BigFriendlyButtonStyle())
                .listRowInsets(.none)
                .listRowSpacing(0)
                .listRowBackground(Color.clear)
                .disabled(adultsCount == 0 && childrenCount == 0)
            }
            .navigationTitle("Book")
            .navigationDestination(for: BookPaths.self) { path in
                switch path {
                case .fromPicker:
                    CityPicker(direction: .from, city: $booking.from)
                case .toPicker:
                    CityPicker(direction: .to, city: $booking.to)
                case .flightSelection:
                    FlightSelectionView(booking: booking, path: $path)
                case .passengers:
                    PassengersInfoView(booking: booking, path: $path)
                default:
                    Text("To be implemented")
                }
            }
        }
    }
}

//#Preview {
//    BookView()
//}
