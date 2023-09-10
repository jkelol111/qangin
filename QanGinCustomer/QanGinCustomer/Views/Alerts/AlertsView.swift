import SwiftUI

struct AlertsView: View {
    let alerts: [Alert] = [
        Alert(
            severity: .info,
            title: "Spring is almost here!",
            body: "Which means it's time to get ready for our spring sales! Head to nice surfs in Gold Coast via Brisbane for $100 round trip, tax exclusive."
        ),
        Alert(
            severity: .delay,
            title: "FS911 delayed",
            body: "Due to operational issues, this flight is being delayed. Please listen to gate announcements and follow staff instructions. We apologize for the inconvenience caused."
        ),
        Alert(severity: .change, title: "FS123 baggage claim changed", body: "Customers should collect their baggage at belt 2 instead of 3.")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(alerts) { alert in
                    AlertItemView(alert: alert)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Alerts")
        }
    }
}

#Preview {
    AlertsView()
}
