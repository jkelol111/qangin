import SwiftUI

struct CityPicker: View {
    enum Direction: String {
        case from = "From"
        case to = "To"
    }
    
    @Environment(\.dismiss) private var dismiss
    let direction: Direction
    @Binding var city: Destinations
    
    @ViewBuilder
    private func pickerItem(_ destination: Destinations) -> some View {
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
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
            city = destination
            dismiss()
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(Destinations.allCases, id: \.self) { destination in
                    pickerItem(destination)
                }
            }
            .padding([.leading, .trailing])
        }
        .navigationTitle(direction.rawValue)
    }
}

#Preview {
    NavigationStack {
        CityPicker(
            direction: .to,
            city: .constant(.sydney)
        )
    }
}
