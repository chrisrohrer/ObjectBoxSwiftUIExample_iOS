//
//  ObjectBoxTestApp.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 07.02.25.
//

import SwiftUI
import ObjectBox


// initialize ObjectBox store and save in global let
let store: Store = initStore(name: "MyLibrary")

@main
struct ObjectBoxTestApp: App {
    
    init() {
        loadExampleData()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
