import Foundation
import Core
import SwiftUI

public class ModuleBEntryPoint {
    
    private let container: Container
    
    public init(container: Container) {
        // Create a child container to prevent other modules from accessing
        // the dependencies added here.
        self.container = Container(parent: container)
        
        // Showcasing module B registering its own local dependency to the module.
        struct ModuleBDependency {}
        
        container.register { ModuleBDependency() }
    }
    
    // Public functions that can be used to create modules views, or other classes.
    public func makeModuleBScreen() -> some View {
        return ModuleBView(container: container)
    }
}
