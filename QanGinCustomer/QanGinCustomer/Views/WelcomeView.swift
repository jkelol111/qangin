import SwiftUI

struct WelcomeView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.clear
                .background {
                    Image("Splash/Background")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                }
                .overlay(alignment: .bottom) {
                    Color.white
                        .frame(height: 140)
                        .opacity(0.4)
                        .blur(radius: 30)
                        .padding(-30)
                }
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Image("Splash/Icon")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .cornerRadius(13)
                        Text("Welcome")
                            .font(.system(size: 48, weight: .semibold))
                        Text("to **Sydney**")
                            .font(.system(size: 24))
                    }
                    Spacer()
                }
                .foregroundStyle(.white)
                .padding([.leading, .trailing], 24)
                .padding(.top, 12)
                Spacer()
                Button("Login") {
                    dismiss()
                }
                .buttonStyle(BigFriendlyButtonStyle())
            }
        }
    }
}

#Preview {
    WelcomeView()
}
