import SwiftUI

struct PassengersInfoView: View {
    struct PassengerEditView: View {
        @Binding var passenger: Booking.Passenger
        let i: Int
        @Binding var seats: [[String: Bool]]
        
        @State private var isSeatSelectionPresented = false
        @State private var previousSelectedSeat: Booking.Passenger.Seat?
        @State private var isServicesSelectionPresented = false
        
        var body: some View {
            DisclosureGroup("#\(i)") {
                TextField("Name", text: $passenger.name)
                    .lineLimit(1)
                TextField("Passport number", text: $passenger.passport)
                    .lineLimit(1)
                Button {
                    isSeatSelectionPresented = true
                } label: {
                    HStack {
                        LabeledContent("Seat", value: passenger.seat?.string ?? "Not selected")
                        Image(systemName: "chevron.right")
                    }
                }
                Button {
                    isServicesSelectionPresented = true
                } label: {
                    HStack {
                        LabeledContent("Services", value: passenger.services.count == 0 ? "None" : "\(passenger.services.count) selected")
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .sheet(isPresented: $isSeatSelectionPresented, onDismiss: {
                if let seat = passenger.seat {
                    seats[seat.row][seat.position] = true
                    if seat != previousSelectedSeat {
                        if let previousSelectedSeat {
                            seats[previousSelectedSeat.row][previousSelectedSeat.position] = false
                        }
                        previousSelectedSeat = seat
                    }
                }
            }) {
                SeatSelectionView(passenger: $passenger, seats: seats)
            }
            .sheet(isPresented: $isServicesSelectionPresented) {
                ServicesSelectionView(passenger: $passenger)
            }
        }
    }
    
    @Bindable var booking: Booking
    @Binding var path: [BookView.Paths]
    
    @State private var seats: [[String: Bool]] = Array(
        repeating: [
            "A": false,
            "B": false,
            "C": false,
            "D": false,
            "E": false,
            "F": false
        ],
        count: 32
    )
    
    var body: some View {
        List {
            if !booking.adults.isEmpty {
                Section("Adults") {
                    ForEach(Array(zip($booking.adults, booking.adults.indices)), id: \.0.id) { adult, i in
                        PassengerEditView(passenger: adult, i: i, seats: $seats)
                    }
                }
            }
            
            if !booking.children.isEmpty {
                Section("Children") {
                    ForEach(Array(zip($booking.children, booking.children.indices)), id: \.0.id) { child, i in
                        PassengerEditView(passenger: child, i: i, seats: $seats)
                    }
                }
            }
            
            Button("Confirm details") {
                path.append(.confirm)
            }
            .buttonStyle(BigFriendlyButtonStyle())
            .listRowInsets(.none)
            .listRowSpacing(0)
            .listRowBackground(Color.clear)
        }
        .navigationTitle("Passengers")
        .onAppear {
            seats[8]["C"] = true
            seats[8]["D"] = true
            seats[17]["A"] = true
            seats[17]["B"] = true
            seats[31]["F"] = true
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        NavigationStack {
            PassengersInfoView(booking: .preview(), path: .constant([]))
        }
        .modelContainer(.preview())
    }
}
