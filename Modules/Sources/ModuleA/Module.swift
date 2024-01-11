import Foundation
import Core
import SwiftUI

public class ModuleAEntryPoint {
    
    private let container: Container
    
    public init(container: Container) {
        // Create a child container to prevent other modules from accessing
        // the dependencies added here.
        self.container = Container(parent: container)
        
        // Showcasing module A registering its own local dependency to the module.
        struct ModuleADependency {}
        
        container.register {ModuleADependency() }
    }
    
    // Public functions that can be used to create modules views, or other classes.
    public func makeModuleAScreen() -> some View {
        // Here is where I would create or get the composable architecture store as I work on the migration.
        
        // Since I'm not migrated to using Dependencies yet I was going to do something like this:
        // let myService: MyService = container.get()
        // let store = Store(initialState: ModuleAFeature.State()) {
        //     ModuleAFeature(service: myService)
        // }

        return ModuleAView(container: container)
    }
}
