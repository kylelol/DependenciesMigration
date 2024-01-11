import Foundation

public struct MyService {
    
    public var doSomething: @Sendable () async throws -> Void
    
    public init(doSomething: @Sendable @escaping () async throws -> Void) {
        self.doSomething = doSomething
    }
}
