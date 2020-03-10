import SwiftUI

extension Text {

  init(_ copy: Copy) {
    self.init(copy.description)
  }
}

extension Color {

  static let offBlack = Color(red: 26/255, green: 26/255, blue: 26/255)
  static let grayLight = Color(red: 133/255, green: 145/255, blue: 155/255)
}

extension View {

  @inlinable func disabled(_ disabled: Bool, brightness: Double) -> some View {
    self.disabled(disabled).brightness(disabled ? brightness : 0)
  }

  var any: AnyView {
    return AnyView(self)
  }
}
