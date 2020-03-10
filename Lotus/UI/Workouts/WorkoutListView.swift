import SwiftUI

struct WorkoutListView: View {

  @ObservedObject var plansQuery = ObservableQuery<MyActivitiesQuery>()

  var body: some View {
    guard let result = self.plansQuery.value else {
      return AnyView(ActivityIndicator(isAnimating: .constant(false), color: .gray, style: .large))
    }
    let activities = result.users.flatMap({
      $0.person.groups.flatMap({
        $0.activityPlans
          .compactMap({ $0.plan })
          .flatMap({ $0.activities })
      })
    })
    return AnyView(List(activities, id: \.id) { Text($0.createdAt) })
  }
}

struct WorkoutListView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutListView()
  }
}
