import Apollo
import Combine

extension ApolloClient {

  func fetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy = .returnCacheDataElseFetch,
    context: UnsafeMutableRawPointer? = nil,
    queue: DispatchQueue = .main
  ) -> Future<GraphQLResult<Query.Data>, Error> {
    Future { self.fetch(query: query, cachePolicy: cachePolicy, context: context, queue: queue, resultHandler: $0) }
  }

  func perform<Mutation: GraphQLMutation>(
    mutation: Mutation,
    context: UnsafeMutableRawPointer? = nil,
    queue: DispatchQueue = .main
  ) -> Future<GraphQLResult<Mutation.Data>, Error> {
    Future { self.perform(mutation: mutation, context: context, queue: queue, resultHandler: $0) }
  }
}
