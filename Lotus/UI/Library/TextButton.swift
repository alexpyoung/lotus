import SwiftUI

struct TextButton: View {

  let title: Copy
  let style: Font.TextStyle
  let action: () -> Void

  var body: some View {
    return
      Button(action: self.action) {
        Text(self.title.description)
          .font(.system(self.style))
          .frame(maxWidth: .infinity)
          .padding(.vertical, 16)
          .foregroundColor(Color.grayLight)
        }
  }
}

struct TextButton_Previews: PreviewProvider {
  static var previews: some View {
    TextButton(title: .login, style: .subheadline, action: {})
  }
}
