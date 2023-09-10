import SwiftUI

struct AlertItemView: View {
    let alert: Alert
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(alert.severity.color)
                    .frame(width: 40, height: 40)
                Image(systemName: alert.severity.icon)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
            }
            
            VStack(alignment: .leading) {
                Text(alert.title)
                    .bold()
                Text(alert.body)
            }
            Spacer()
        }
    }
}
