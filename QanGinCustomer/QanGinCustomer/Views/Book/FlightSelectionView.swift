import SwiftUI

struct FlightSelectionView: View {
    enum Direction: String {
        case forward = "Departing flight"
        case backwards = "Returning flight"
    }
    
    let direction: Direction
    @Bindable var booking: Booking
    @Binding var path: [BookView.Paths]
    
    @State private var flights: [Booking.Flight] = []
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(flights) { flight in
                    HStack {
                        VStack(alignment: .leading) {
                            Label(flight.id, systemImage: "airplane")
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
                        switch direction {
                        case .forward:
                            booking.forwardFlight = flight
                        case .backwards:
                            booking.returnFlight = flight
                        }
                        if booking.isReturn && booking.returnFlight == nil {
                            path.append(.flightSelection(.backwards))
                        } else {
                            path.append(.passengers)
                        }
                    }
                }
            }
            .padding([.leading, .trailing])
        }
        .navigationTitle(direction.rawValue)
        .onAppear {
            if flights.isEmpty {
                for i in 1...3 {
                    flights.append(
                        .init(
                            id: "FS\(100 + i)", flyingOn: Date(timeInterval: 86400 * Double(i), since: direction == .forward ? booking.flyingOn : booking.returningOn)
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
                direction: .forward,
                booking: .preview(),
                path: .constant([.flightSelection(.forward)])
            )
        }
        .modelContainer(.preview())
    }
}
