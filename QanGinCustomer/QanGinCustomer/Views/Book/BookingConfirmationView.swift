import SwiftUI
import SwiftData

struct BookingConfirmationView: View {
    let booking: Booking
    @Binding var path: [BookView.Paths]
    @Binding var selectedTab: RootTabView.Tabs
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var isCancelAlertPresented = false
    
    @ViewBuilder
    private func flightInfoView(_ flight: Booking.Flight) -> some View {
        HStack {
            Image(systemName: "airplane")
                .font(.title)
            VStack(alignment: .leading) {
                Text(flight.id)
                    .bold()
                    .monospaced()
                Text(flight.flyingOn, style: .date)
            }
        }
    }
    
    @ViewBuilder
    private func passengerInfoView(_ passenger: Booking.Passenger) -> some View {
        VStack {
            HStack {
                Image(systemName: "figure.stand")
                    .font(.title)
                VStack(alignment: .leading) {
                    Text(passenger.name)
                        .bold()
                    Text(passenger.passport)
                        .monospaced()
                }
                Spacer()
                Text(passenger.seat?.string ?? "N/A")
                    .padding(6)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .font(.title3.monospacedDigit().bold())
            }
            ForEach(Array(passenger.services.keys), id: \.self) { service in
                LabeledContent {
                    Text(String(passenger.services[service] ?? 0))
                } label: {
                    Label(service.rawValue, systemImage: service.icon)
                }
            }
        }
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("From")
                        .fontWeight(.semibold)
                    Text(booking.from.rawValue)
                        .font(.title2.bold())
                }
                .shadow(radius: 30)
                .foregroundStyle(.white)
                .listRowBackground(
                    Image("Destinations/\(booking.from.rawValue)")
                        .resizable()
                        .scaledToFill()
                )
                
                VStack(alignment: .leading) {
                    Text("To")
                        .fontWeight(.semibold)
                    Text(booking.to.rawValue)
                        .font(.title2.bold())
                }
                .shadow(radius: 30)
                .foregroundStyle(.white)
                .listRowBackground(
                    Image("Destinations/\(booking.to.rawValue)")
                        .resizable()
                        .scaledToFill()
                )
            }
            
            Section("Flights") {
                if let departingFlight = booking.forwardFlight {
                    LabeledContent {
                        VStack(alignment: .trailing) {
                            Text(departingFlight.flyingOn, style: .time)
                            Text("\(booking.from.rawValue) Time")
                        }
                    } label: {
                        Label("Departing", systemImage: "airplane.departure")
                    }
                }
                if let returnFlight = booking.returnFlight {
                    LabeledContent {
                        VStack(alignment: .trailing) {
                            Text(returnFlight.flyingOn, style: .time)
                            Text("\(booking.to.rawValue) Time")
                        }
                    } label: {
                        Label("Returning", systemImage: "airplane.arrival")
                    }
                }
            }
            
            
            Section("Passengers") {
                DisclosureGroup("Adults", isExpanded: .constant(true)) {
                    ForEach(booking.adults) { adult in
                        passengerInfoView(adult)
                    }
                }
                DisclosureGroup("Children", isExpanded: .constant(true)) {
                    ForEach(booking.children) { child in
                        passengerInfoView(child)
                    }
                }
            }
            
            Section("Price") {
                LabeledContent("Subtotal", value: String(booking.subtotal()))
                LabeledContent("Taxes (incl. airport fees)", value: "128.64")
                LabeledContent("Total", value: String(booking.subtotal() + 128.64))
            }
            
            Button(booking.isBooked ? "Cancel booking" : "Confirm selections") {
                if booking.isBooked {
                    isCancelAlertPresented = true
                } else {
                    booking.isBooked = true
                    modelContext.insert(booking)
                    self.path = []
                    self.selectedTab = .mine
                }
            }
            .buttonStyle(BigFriendlyButtonStyle())
            .listRowInsets(.none)
            .listRowSpacing(0)
            .listRowBackground(Color.clear)
            .alert("Cancel this booking?", isPresented: $isCancelAlertPresented) {
                Button("Yes", role: .destructive) {
                    modelContext.delete(booking)
                    dismiss()
                }
            }
        }
        .navigationTitle(booking.isBooked ? "Booking" : "Confirmation")
    }
}

#Preview {
    BookingConfirmationView(
        booking: .preview(),
        path: .constant([.confirm]),
        selectedTab: .constant(.book)
    )
}
