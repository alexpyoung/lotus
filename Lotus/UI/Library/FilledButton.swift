import SwiftUI

struct FilledButton: View {

  let title: Copy
  @Binding var isLoading: Bool
  let action: () -> Void

  var content: some View {
    self.isLoading
      ? AnyView(ActivityIndicator(
        isAnimating: .constant(true),
        color: .white,
        style: .medium
      ))
      : AnyView(Text(self.title.description).fontWeight(.bold))
  }

  var body: some View {
    Button(action: self.action) {
      self.content
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.blue)
        .foregroundColor(Color.white)
        .cornerRadius(6)
    }
  }
}

struct FilledButton_Previews: PreviewProvider {
  static var previews: some View {
    FilledButton(title: .login, isLoading: .constant(false), action: {})
  }
}