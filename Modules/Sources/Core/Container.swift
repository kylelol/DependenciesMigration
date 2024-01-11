import Foundation

/// Current implementation of service locator pattern
public final class Container {
    
    private enum ServiceState {
        case pending((Container) -> Any)
        case resolving
        case resolved(Any)
    }
    
    private weak var unsafeParent: Container?
    private var registry: [String: ServiceState] = [:]
    private let queue = DispatchQueue(label: "com.module.core.Container")
    
    public init(parent: Container? = nil) {
        self.unsafeParent = parent
    }
    
    public var parent: Container? {
        get { queue.sync { unsafeParent } }
        set { queue.sync { unsafeParent = newValue} }
    }
    
    public func register<Interface>(_ provider: @escaping (Container) -> Interface) {
        register(Interface.self, provider)
    }
    
    public func register<Interface>(_ provider: @escaping () -> Interface) {
        register(Interface.self, provider)
    }
    
    public func register<Interface>(_ interface: Interface.Type, _ provider: @escaping () -> Interface) {
        register(interface, {_ in provider() })
    }
    
    public func register<Interface>(_ interface: Interface.Type, _ provider: @escaping (Container) -> Interface) {
        let id = identifier(for: interface)
        
        queue.sync {
            switch registry[id] {
            case .resolved:
                fatalError("Cannot register a new provider for \(Interface.self) becuase it has been resolved.")
            case .resolving:
                fatalError("Cannot register a new provider for \(Interface.self) becuase it is being resolved")
            case .pending, nil:
                registry[id] = .pending(provider)
            }
        }
    }
    
    public func get<Interface>(_ interface: Interface.Type = Interface.self) -> Interface {
        getIfRegistered(interface)!
    }
    
    public func getIfRegistered<Interface>(_ interface: Interface.Type = Interface.self) -> Interface? {
        resolve() ?? parent?.getIfRegistered()
    }
    
    private func resolve<Interface>() -> Interface? {
        let id = identifier(for: Interface.self)
        let start = Date()
        
        while true {
            let state: ServiceState? = queue.sync {
                let state = registry[id]
                
                if case .pending = state {
                    registry[id] = .resolving
                }
                
                return state
            }
            
            switch state {
            case nil:
                return nil
            case .resolved(let service):
                return (service as! Interface)
            case .resolving:
                if -start.timeIntervalSinceNow > 5 {
                    fatalError("Waited more than 5 seconds seconds for some other call to resolve")
                }
            case .pending(let provider):
                let service = provider(self)
                queue.sync { registry[id] = .resolved(service) }
                return (service as! Interface)
            }
        }
    }
}

private func identifier(for type: Any.Type) -> String {
    String(describing: type)
}
