import SwiftUI

struct ErrorView: View {

  let error: Error

  init(_ error: Error) {
    self.error = error
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(Copy.errorTitle)
        .font(.system(.largeTitle))
        .fontWeight(.bold)
        .foregroundColor(.navy)
      Text(Copy.errorSubtitle)
        .fontWeight(.bold)
        .font(.system(.headline))
        .foregroundColor(.navy)
      Text(self.error.localizedDescription)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.system(.headline))
        .foregroundColor(.salmon)
    }
    .padding(.horizontal, 24)
  }
}

struct ErrorView_Previews: PreviewProvider {
  static var previews: some View {
    ErrorView(AuthenticationError.jwtPersistence)
  }
}
