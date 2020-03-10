import SwiftUI

private typealias Plan = MyActivityPlansQuery.Data.User.Person.Group.ActivityPlan

struct PlanListView: View {

  @ObservedObject var plansQuery = ObservableQuery<MyActivityPlansQuery>()

  var body: some View {
    guard let result = self.plansQuery.value else {
      return AnyView(ActivityIndicator(isAnimating: .constant(false), color: .gray, style: .large))
    }
    let plans = result.users.flatMap({
      $0.person.groups.flatMap({
        $0.activityPlans.compactMap({ $0.plan })
      })
    })
    return AnyView(List(plans, id: \.id) { Text($0.name) })
  }
}

struct PlanListView_Previews: PreviewProvider {
  static var previews: some View {
    PlanListView()
  }
}
