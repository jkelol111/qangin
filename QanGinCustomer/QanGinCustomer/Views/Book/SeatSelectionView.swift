import SwiftUI

struct SeatSelectionView: View {
    @Binding var passenger: Booking.Passenger
    let seats: [[String: Bool]]
    
    @Environment(\.dismiss) private var dismiss
    
    @ViewBuilder
    private func seat(_ seat: Booking.Passenger.Seat) -> some View {
        Button {
            if seats[seat.row][seat.position]! {
                return
            }
            passenger.seat = seat
        } label: {
            ZStack {
                if passenger.seat == seat {
                    Color.orange
                } else if seats[seat.row][seat.position]! {
                    Color.red
                } else {
                    Color.blue
                }
                Text(seat.position)
                    .foregroundStyle(.white)
            }
        }
        .frame(width: 48, height: 48)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Grid {
                    ForEach(seats.indices, id: \.self) { i in
                        GridRow {
                            ForEach(Array(seats[i].keys.sorted()), id: \.self) { pos in
                                seat(.init(row: i, position: pos))
                                if pos == "C" {
                                    Spacer()
                                    Text(String(i + 1))
                                        .font(.body.monospacedDigit().bold())
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .padding([.leading, .trailing], 24)
            }
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    Text("Seat")
                        .font(.headline)
                        .foregroundStyle(.gray)
                    Text(passenger.seat?.string ?? "N/A")
                        .font(.largeTitle.bold())
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Price")
                        .font(.headline)
                        .foregroundStyle(.gray)
                    Text(String(passenger.seat?.price ?? 0.0))
                        .font(.largeTitle.bold())
                }
            }
            .padding([.leading, .trailing])
            Button("Select seat") {
                dismiss()
            }
            .buttonStyle(BigFriendlyButtonStyle())
            .navigationTitle("Seat selection")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//#Preview {
//    SeatSelectionView(
//        passenger: .constant(Booking.Passenger.preview)
//    )
//}
