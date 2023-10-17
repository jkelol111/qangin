import SwiftUI

struct ServicesSelectionView: View {
    @Binding var passenger: Booking.Passenger
    
    @Environment(\.dismiss) private var dismiss
    @State private var foodCount = 0
    @State private var drinksCount = 0
    @State private var dutyFreeCount = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Label("Food", systemImage: "fork.knife")
                            .font(.title.bold())
                        Spacer()
                        Text(String(foodCount))
                            .font(.body.monospacedDigit())
                        Stepper("Food", value: $foodCount, in: 0...2)
                            .labelsHidden()
                    }
                    .padding([.top, .leading, .trailing])
                    Text("Enjoy our award-winning dining experience onboard. Includes 3 courses for each meal.")
                    Spacer()
                }
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onChange(of: foodCount) {
                    if foodCount > 0 {
                        passenger.services[.food] = foodCount
                    } else {
                        passenger.services.removeValue(forKey: .food)
                    }
                }
                
                VStack {
                    HStack {
                        Label("Drinks", systemImage: "wineglass.fill")
                            .font(.title.bold())
                        Spacer()
                        Text(String(drinksCount))
                            .font(.body.monospacedDigit())
                        Stepper("Drinks", value: $drinksCount, in: 0...2)
                            .labelsHidden()
                    }
                    .padding([.top, .leading, .trailing])
                    Text("Pick from our worldwide selection of drinks. Menu available onboard.")
                    Spacer()
                }
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onChange(of: drinksCount) {
                    if drinksCount > 0 {
                        passenger.services[.drinks] = drinksCount
                    } else {
                        passenger.services.removeValue(forKey: .drinks)
                    }
                }
                .padding([.top])
                
                VStack {
                    HStack {
                        Label("Duty-free", systemImage: "bag.fill")
                            .font(.title.bold())
                        Spacer()
                        Text(String(dutyFreeCount))
                            .font(.body.monospacedDigit())
                        Stepper("Duty-free", value: $dutyFreeCount, in: 0...3)
                            .labelsHidden()
                    }
                    .padding([.top, .leading, .trailing])
                    Text("Stock up on your favorite duty-free goods, delivered straight to your plane.")
                    Spacer()
                }
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onChange(of: dutyFreeCount) {
                    if dutyFreeCount > 0 {
                        passenger.services[.dutyFree] = dutyFreeCount
                    } else {
                        passenger.services.removeValue(forKey: .dutyFree)
                    }
                }
                .padding([.top])
                
                Button("Confirm selections") {
                    dismiss()
                }
                .buttonStyle(BigFriendlyButtonStyle())
                .padding([.top])
            }
            .padding()
            .navigationTitle("Select services")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let food = passenger.services[.food] {
                    foodCount = food
                }
                if let drinks = passenger.services[.drinks] {
                    drinksCount = drinks
                }
                if let dutyFree = passenger.services[.dutyFree] {
                    dutyFreeCount = dutyFree
                }
            }
        }
    }
}

//#Preview {
//    ServicesSelectionView()
//}
