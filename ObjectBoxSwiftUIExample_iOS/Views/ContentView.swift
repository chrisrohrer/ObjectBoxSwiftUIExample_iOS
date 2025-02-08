//
//  ContentView.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 26.01.25.
//

import SwiftUI

// Primary Tab View

struct ContentView: View {
    
    var body: some View {
        TabView {
            AuthorsView()
                .tabItem { Label("Authors", systemImage: "person") }

            BooksView()
                .tabItem { Label("Books", systemImage: "book") }
        }
    }
}


