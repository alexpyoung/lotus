import SwiftUI

struct Loading<Content>: View where Content: View {

  @Binding var isLoading: Bool
  let action: () -> Void
  let content: () -> Content

  var body: some View {
    return self.isLoading
      ? AnyView(
        ActivityIndicator(
          isAnimating: .constant(true),
          color: .gray,
          style: .large
        )
        .onAppear { self.action() }
      )
      : AnyView(self.content())
  }
}

struct Loading_Previews: PreviewProvider {
  static var previews: some View {
    Loading(isLoading: .constant(true), action: {}, content: { EmptyView() })
  }
}
