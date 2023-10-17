import SwiftUI

struct BookingItemView: View {
    let booking: Booking
    
    var body: some View {
        NavigationLink(value: booking) {
            HStack {
                VStack(alignment: .leading) {
                    Text(booking.to.rawValue)
                        .font(.title.bold())
                    Text(booking.id)
                        .font(.body.monospaced())
                }
                .padding()
                .shadow(radius: 30)
                Spacer()
                VStack(alignment: .trailing) {
                    HStack {
                        Text(String(booking.totalPassengers()))
                        Image(systemName: "figure.stand")
                    }
                    HStack {
                        Text(booking.forwardFlight?.flyingOn ?? .now, style: .time)
                        Image(systemName: "airplane.departure")
                    }
                }
                .padding()
                .shadow(radius: 30)
            }
            .background {
                Image("Destinations/\(booking.to.rawValue)")
                    .resizable()
                    .scaledToFill()
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        ScrollView {
            LazyVStack {
                BookingItemView(
                    booking: .preview()
                )
                BookingItemView(
                    booking: .preview()
                )
            }
            .padding([.leading, .trailing])
        }
        
        .modelContainer(.preview())
    }
}
