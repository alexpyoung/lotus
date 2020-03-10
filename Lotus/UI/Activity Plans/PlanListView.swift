import SwiftUI

struct PlanListView: View {

  @ObservedObject private var query = ObservableQuery<MyActivityPlansQuery>()

  var body: some View {
    switch self.query.state {
    case .loading:
      return AnyView(ActivityIndicator(isAnimating: .constant(false), color: .gray, style: .large))
    case .success(let result):
      let plans = result.users.flatMap({
        $0.person.groups.flatMap({
          $0.activityPlans.compactMap({ $0.plan })
        })
      })
      return AnyView(List(plans, id: \.id) { Text($0.name) })
    case .error:
      return AnyView(EmptyView()) // TODO
    }
  }
}

struct PlanListView_Previews: PreviewProvider {
  static var previews: some View {
    PlanListView()
  }
}
