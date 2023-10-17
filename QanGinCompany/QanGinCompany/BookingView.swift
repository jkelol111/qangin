import SwiftUI

struct BookingView: View {
    @Binding var flight: Flight
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section("Info") {
                DisclosureGroup("Departure", isExpanded: .constant(true)) {
                    LabeledContent("Airport", value: flight.departingAirport)
                    LabeledContent("Date") {
                        Text(flight.departureDate, style: .date)
                    }
                    LabeledContent("Time") {
                        Text(flight.departureDate, style: .time)
                    }
                }
                DisclosureGroup("Arrival", isExpanded: .constant(true)) {
                    LabeledContent("Airport", value: flight.arrivingAirport)
                    LabeledContent("Date") {
                        Text(flight.arrivalDate, style: .date)
                    }
                    LabeledContent("Time") {
                        Text(flight.arrivalDate, style: .time)
                    }
                }
            }
            Section("Bookings") {
                ForEach(flight.bookings) { booking in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(booking.id)
                                .bold()
                            Text("\(booking.passengers) passengers")
                        }
                        Spacer()
                        ForEach(booking.services, id: \.self) { service in
                            Image(systemName: service.rawValue)
                                .foregroundStyle(.accent)
                        }
                    }
                    .strikethrough(booking.isCancelled, color: .red)
                    .foregroundStyle(booking.isCancelled ? .red : .white)
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            if let i = flight.bookings.firstIndex(of: booking) {
                                flight.bookings[i].isCancelled.toggle()
                            }
                        } label: {
                            if booking.isCancelled {
                                Label("Rebook", systemImage: "checkmark")
                            } else {
                                Label("Cancel booking", systemImage: "xmark")
                            }
                        }
                        .tint(booking.isCancelled ? .green : .red)
                    }
                }
            }
        }
        .navigationTitle(flight.id)
        .toolbar {
            Button {
                flight.isCancelled = true
                dismiss()
            } label: {
                Label("Cancel flight", systemImage: "xmark")
            }
        }
    }
}
