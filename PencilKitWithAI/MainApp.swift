//
//  MainApp.swift
//  PencilKitWithAI
//

import SwiftUI

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataRepository())
                .environmentObject(NetworkRepository())
        }
    }
}
