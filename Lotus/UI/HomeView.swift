import SwiftUI

struct HomeView: View {
  var body: some View {
    TabView {
      Text("The First Tab")
        .tabItem {
          Image(systemName: "sun.haze.fill")
          Text(.workouts)
        }
      PlanListView()
        .tabItem {
          Image(systemName: "tray.full")
          Text(.plans)
      }
      Text("Another One")
        .tabItem {
          Image(systemName: "person.crop.circle")
          Text(.account)
      }
    }
    .font(.headline)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
