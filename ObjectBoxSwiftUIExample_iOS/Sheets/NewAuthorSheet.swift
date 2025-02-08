//
//  NewProductSheet.swift
//  PraxisBestand
//
//  Created by Christoph Rohrer on 06.02.25.
//

import SwiftUI
import ObjectBox


struct NewAuthorSheet: View {
    
    @State private var name: String = ""
    @State private var birthyear: Int = 1900
    
    var body: some View {
        NewSheet(title: "New Author") {
            Section("Author") {
                TextField("Name", text: $name)
                    .font(.headline)
                TextField("Birth year", value: $birthyear, format: .number.grouping(.never))
            }
            
        } action: {
            withAnimation {
                let new = Author(name: name, birthyear: birthyear)
                _ = try? store.box(for: Author.self).put(new)
            }
        } disabled: {
            name.isEmpty
        }
    }
}


