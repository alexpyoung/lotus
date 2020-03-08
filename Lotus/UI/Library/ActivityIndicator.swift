import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

  @Binding var isAnimating: Bool
  let color: UIColor
  let style: UIActivityIndicatorView.Style

  func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
    let view = UIActivityIndicatorView(style: style)
    view.color = self.color
    return view
  }

  func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
    isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
  }
}
