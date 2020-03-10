import SwiftUI

struct HomeView: View {
  var body: some View {
    TabView {
      WorkoutListView()
        .tabItem {
          Image(systemName: "sun.haze.fill")
          Text(.workouts)
        }
      PlanListView()
        .tabItem {
          Image(systemName: "tray.full")
          Text(.plans)
      }
      ProfileView()
        .tabItem {
          Image(systemName: "person.crop.circle")
          Text(.me)
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
