import SwiftUI

struct BookingItemView: View {
    let booking: Booking
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(booking.to.rawValue)
                    .font(.title.bold())
                Text(booking.id)
                    .font(.body.monospaced())
            }
            Spacer()
            
        }
        .background {
            Image("Destinations/\(booking.to.rawValue)")
                .resizable()
                .scaledToFill()
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
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
