import SwiftUI

struct PlanListView: View {

  @ObservedObject private var query = ObservableQuery<MyActivityPlansQuery>()

  var body: some View {
    switch self.query.state {
    case .loading:
      return ActivityIndicator(isAnimating: .constant(false), color: .gray, style: .large).any
    case .success(let result):
      let plans = result.users.flatMap({
        $0.person.groups.flatMap({
          $0.activityPlans.compactMap({ $0.plan })
        })
      })
      return List(plans, id: \.id) { Text($0.name) }.any
    case .error(let error):
      return ErrorView(error).any
    }
  }
}

struct PlanListView_Previews: PreviewProvider {
  static var previews: some View {
    PlanListView()
  }
}
