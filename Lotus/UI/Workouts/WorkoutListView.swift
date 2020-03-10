import SwiftUI

struct WorkoutListView: View {

  @ObservedObject private var query = ObservableQuery<MyActivitiesQuery>()

  var body: some View {
    switch self.query.state {
    case .loading:
      return ActivityIndicator(isAnimating: .constant(false), color: .gray, style: .large).any
    case .success(let result):
      let activities = result.users.flatMap({
        $0.person.groups.flatMap({
          $0.activityPlans
            .compactMap({ $0.plan })
            .flatMap({ $0.activities })
        })
      })
      return List(activities, id: \.id) { Text($0.createdAt) }.any
    case .error(let error):
      return ErrorView(error).any
    }
  }
}

struct WorkoutListView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutListView()
  }
}
