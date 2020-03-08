import SwiftUI

enum RoundedButtonStyle {
  case filled
  case outline
}

struct RoundedButton: View {

  let title: Copy
  let style: RoundedButtonStyle
  let action: () -> Void

  var body: some View {
    switch self.style {
    case .filled:
      return
        AnyView(Button(action: self.action) {
          Text(self.title.description)
            .fontWeight(.bold)
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(6)
          }
        )
    case .outline:
      return
        AnyView(Button(action: self.action) {
          Text(self.title.description)
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .background(Color.white)
            .foregroundColor(Color.blue)
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.blue, lineWidth: 1))
          }
        )
    }
  }
}

struct RoundedButton_Previews: PreviewProvider {
  static var previews: some View {
    RoundedButton(title: .login, style: .filled, action: {})
  }
}
