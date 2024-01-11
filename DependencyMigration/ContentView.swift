//
//  ContentView.swift
//  DependencyMigration
//
//  Created by Kyle Kirkland on 1/11/24.
//

import SwiftUI
import Core
import ModuleA
import ModuleB

struct ContentView: View {
    
    let container: Container
    let showModuleA: Bool
    
    var moduleAEntryPoint: ModuleAEntryPoint {
        return container.get()
    }
    
    var moduleBEntryPoint: ModuleBEntryPoint {
        return container.get()
    }
    
    var body: some View {
        if showModuleA {
            moduleAEntryPoint.makeModuleAScreen()
        } else {
            moduleBEntryPoint.makeModuleBScreen()
        }
    }
}
