//
//  DependencyMigrationApp.swift
//  DependencyMigration
//
//  Created by Kyle Kirkland on 1/11/24.
//

import SwiftUI
import Core
import MyService
import MyServiceLive
import ModuleA
import ModuleB

extension Container {
    // I create a root container that will get passed down into all my features.
    // Whatever is registered here will be available to them.
    static let shared: Container = {
        var container = Container()
        
        // Register `MyService` with the live implementation.
        container.register(MyService.self) { .live }
        
        // Register the modules entry point
        container.register { ModuleAEntryPoint(container: $0) }
        container.register { ModuleBEntryPoint(container: $0) }
        
        return container
    }()
}

@main
struct DependencyMigrationApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(container: .shared, showModuleA: true)
        }
    }
}
