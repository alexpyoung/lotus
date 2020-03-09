import SwiftUI

private typealias Plan = MyActivityPlansQuery.Data.User.Person.Group.ActivityPlan

struct PlanListView: View {

  @EnvironmentObject var person: Person
  @State private var plans: [String] = []
  @State private var isLoading: Bool = true

  var body: some View {
    guard let auth0id = self.person.auth0id else {
      return AnyView(EmptyView())
    }
    return AnyView(Loading(
      isLoading: self.$isLoading,
      action: {
        Network.shared.apollo.fetch(query: MyActivityPlansQuery(auth0id: auth0id)) {
          self.isLoading = false
          switch $0 {
          case .success(let result):
            if let plans = result.data.flatMap({
              $0.users.flatMap({
                $0.person.groups.flatMap({ $0.activityPlans.compactMap({ $0.plan.flatMap({ $0.name })}) })
              })
            }) {
              print(plans)
              self.plans = plans
            }
          case .failure(let error):
            print(error)
          }
        }
      },
      content: {
        Text("\(self.plans.first ?? "Whoops")")
      }
    ))
  }
}

struct PlanListView_Previews: PreviewProvider {
  static var previews: some View {
    PlanListView()
  }
}
