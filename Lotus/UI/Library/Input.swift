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
      return TextField(self.label.description, text: self.$value).any
    case .secure:
      return SecureField(self.label.description, text: self.$value).any
    }
  }

  var body: some View {
    VStack {
      self.field
      Divider()
    }
    .padding(.vertical, 8)
  }
}

struct Input_Previews: PreviewProvider {
  static var previews: some View {
    Input(label: .email, value: .constant(""), style: .plaintext)
  }
}
