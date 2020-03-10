import SwiftUI

struct WorkoutListView: View {

  @ObservedObject private var query = ObservableQuery<MyActivitiesQuery>()

  var body: some View {
    switch self.query.state {
    case .loading:
      return AnyView(ActivityIndicator(isAnimating: .constant(false), color: .gray, style: .large))
    case .success(let result):
      let activities = result.users.flatMap({
        $0.person.groups.flatMap({
          $0.activityPlans
            .compactMap({ $0.plan })
            .flatMap({ $0.activities })
        })
      })
      return AnyView(List(activities, id: \.id) { Text($0.createdAt) })
    case .error:
      return AnyView(EmptyView()) // TODO
    }
  }
}

struct WorkoutListView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutListView()
  }
}
