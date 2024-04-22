import Foundation
import SwiftUI

//initializers
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

struct CustomColors {
    let red=Color(hex:0xDC143C)
    let gray=Color(hex:0x121212)
    let blue=Color(hex:0x318CE7)
}

// custom colors
extension Color {
    static let custom = CustomColors()
}
