import SwiftUI

struct FlightSelectionView: View {
    struct Flight: Identifiable {
        let id = UUID()
        let flyingOn: Date
        let aircraft: String
    }
    
    @Bindable var booking: Booking
    @Binding var path: [BookView.BookPaths]
    
    @State private var flights: [Flight] = []
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(flights) { flight in
                    HStack {
                        VStack(alignment: .leading) {
                            Label(flight.aircraft, systemImage: "airplane")
                            HStack(alignment: .lastTextBaseline) {
                                Text("in")
                                    .font(.subheadline)
                                Text(flight.flyingOn, style: .relative)
                                    .font(.title2.weight(.semibold))
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.compact.right")
                            .font(.largeTitle)
                    }
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        booking.flyingOn = flight.flyingOn
                        booking.aircraft = flight.aircraft
                        path.append(.passengers)
                    }
                }
            }
            .padding([.leading, .trailing])
        }
        .navigationTitle("Departing flight")
        .onAppear {
            if flights.isEmpty {
                for i in 1...3 {
                    flights.append(
                        Flight(
                            flyingOn: Date(timeInterval: 86400 * Double(i), since: booking.flyingOn),
                            aircraft: "Airbus A320-200"
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        NavigationStack {
            FlightSelectionView(
                booking: .preview(),
                path: .constant([.flightSelection])
            )
        }
        .modelContainer(.preview())
    }
}
