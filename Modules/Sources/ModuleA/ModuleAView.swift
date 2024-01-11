//
//  SwiftUIView.swift
//  
//
//  Created by Kyle Kirkland on 1/11/24.
//

import SwiftUI
import Core
import MyService


struct ModuleAView: View {
    let container: Container
    
    var body: some View {
        Text("Hello from module A")
            .task {
                do {
                    // Grabbing a service that was registered at the app target level.
                    // But we depend just on the interface module of it.
                    let myService: MyService = container.get()
                    try await myService.doSomething()
                } catch {
                    
                }
            }
    }
}
