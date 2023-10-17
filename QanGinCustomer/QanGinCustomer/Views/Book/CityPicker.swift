import SwiftUI

struct CityPicker: View {
    enum Direction: String {
        case from = "From"
        case to = "To"
    }
    
    @Environment(\.dismiss) private var dismiss
    let direction: Direction
    @Bindable var booking: Booking
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(Destinations.allCases, id: \.self) { destination in
                    HStack {
                        Text(destination.rawValue)
                            .font(.title.weight(.semibold))
                            .padding([.top, .bottom], 24)
                            .padding(.leading, 14)
                            .shadow(radius: 30)
                        Spacer()
                    }
                    .foregroundStyle(.white)
                    .background {
                        Image("Destinations/\(destination.rawValue)")
                            .resizable()
                            .scaledToFill()
                    }
                    .overlay {
                        switch direction {
                        case .from:
                            if booking.to == destination {
                                Color.black
                                    .opacity(0.8)
                            }
                        case .to:
                            if booking.from == destination {
                                Color.black
                                    .opacity(0.8)
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        switch direction {
                        case .from:
                            if booking.to == destination {
                                print("from = to")
                                return
                            }
                            booking.from = destination
                        case .to:
                            if booking.from == destination {
                                print("to = from")
                                return
                            }
                            booking.to = destination
                        }
                        dismiss()
                    }
                }
            }
            .padding([.leading, .trailing])
        }
        .navigationTitle(direction.rawValue)
        .onDisappear {
            print("from: \(booking.from.rawValue)")
            print("to: \(booking.to.rawValue)")
        }
    }
}

#Preview {
    NavigationStack {
        CityPicker(
            direction: .to,
            booking: .preview()
        )
    }
}
