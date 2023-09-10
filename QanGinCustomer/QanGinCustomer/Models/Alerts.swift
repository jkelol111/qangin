import SwiftUI

struct Alert: Identifiable {
    enum Severity: String {
        case info
        case delay
        case change
        
        var icon: String {
            switch self {
            case .info:
                "info.bubble.fill"
            case .delay:
                "airplane.departure"
            case .change:
                "arrowshape.left.arrowshape.right.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .info:
                .blue
            case .delay:
                .yellow
            case .change:
                .purple
            }
        }
    }
    
    let id = UUID()
    let severity: Severity
    let title: String
    let body: String
}
