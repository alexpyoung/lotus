import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  let person = Person()

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    let contentView = RootView()
      .environmentObject(self.person)
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: contentView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}
