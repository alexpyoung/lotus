import SwiftUI

enum InputStyle {
  case plaintext
  case secure
}

struct Input: View {

  let label: Copy
  @Binding var value: String
  let style: InputStyle

  var field: some View {
    switch self.style {
    case .plaintext:
      return AnyView(TextField(self.label.description, text: self.$value))
    case .secure:
      return AnyView(SecureField(self.label.description, text: self.$value))
    }
  }

  var body: some View {
    self.field
      .padding(.vertical, 12)
      .padding(.horizontal, 24)
      .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
  }
}

struct Input_Previews: PreviewProvider {
  static var previews: some View {
    Input(label: .email, value: .constant(""), style: .plaintext)
  }
}
