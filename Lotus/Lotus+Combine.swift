import Combine

protocol Sink {

  associatedtype Output
  associatedtype Failure: Error

  func value(output: Output)
  func completion(completion: Subscribers.Completion<Failure>)
}

extension Publisher {

  func sink<T: Sink>(_ sink: T) -> AnyCancellable where T.Output == Self.Output, T.Failure == Self.Failure {
    return self.sink(receiveCompletion: sink.completion, receiveValue: sink.value)
  }
}
