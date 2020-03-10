import SwiftUI

extension Text {

  init(_ copy: Copy) {
    self.init(copy.description)
  }
}

extension Color {

  static let offBlack = Color(red: 26/255, green: 26/255, blue: 26/255)
  static let grayLight = Color(red: 133/255, green: 145/255, blue: 155/255)
  static let navy = Color(red: 33/255, green: 36/255, blue: 61/255)
  static let salmon = Color(red: 1, green: 124/255, blue: 124/255)
  static let mustard = Color(red: 1, green: 208/255, blue: 130/255)
  static let aqua = Color(red: 136/255, green: 225/255, blue: 242/255)
}

extension UIColor {

  static let navy = UIColor(red: 33/255, green: 36/255, blue: 61/255, alpha: 1)
  static let salmon = UIColor(red: 1, green: 124/255, blue: 124/255, alpha: 1)
  static let mustard = UIColor(red: 1, green: 208/255, blue: 130/255, alpha: 1)
  static let aqua = UIColor(red: 136/255, green: 225/255, blue: 242/255, alpha: 1)
}

extension View {

  @inlinable func disabled(_ disabled: Bool, brightness: Double) -> some View {
    self.disabled(disabled).brightness(disabled ? brightness : 0)
  }

  var any: AnyView {
    return AnyView(self)
  }
}
