import SwiftUI

struct BigFriendlyButtonStyle: ButtonStyle {
    var tint = Color.accentColor
    
    func makeBody(configuration: Configuration) -> some View {
        WrapperButton(tint: self.tint, configuration: configuration)
    }
    
    private struct WrapperButton: View {
        @Environment(\.isEnabled) private var isEnabled
        
        let tint: Color
        let configuration: ButtonStyle.Configuration
        
        var body: some View {
            self.configuration.label
                .bold()
                .padding([.top, .bottom])
                .frame(width: 320)
                .background(self.tint)
                .foregroundStyle(.white)
                .opacity(self.configuration.isPressed || !self.isEnabled ? 0.6 : 1)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    Button("Big Friendly Button") {
        print("I am a Big Friendly Button, descendant of the BFG.")
    }
    .buttonStyle(BigFriendlyButtonStyle())
}
