enum Destinations: String, Codable, CaseIterable {
    case sydney = "Sydney"
    case melbourne = "Melbourne"
    case brisbane = "Brisbane"
    case perth = "Perth"
    case darwin = "Darwin"
    case hobart = "Hobart"
    
    var code: String {
        switch self {
        case .sydney:
            "SYD"
        case .melbourne:
            "MEL"
        case .brisbane:
            "BNE"
        case .perth:
            "PER"
        case .darwin:
            "DRW"
        case .hobart:
            "HBA"
        }
    }
}
