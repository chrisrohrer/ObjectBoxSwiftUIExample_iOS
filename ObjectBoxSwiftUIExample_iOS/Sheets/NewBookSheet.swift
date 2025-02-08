//
//  NewProductSheet.swift
//
//  Created by Christoph Rohrer on 06.02.25.
//

import SwiftUI
import ObjectBox


struct NewBookSheet: View {
    
    @ObservedResults(orderedBy: Author.name)
    private var authors: [Author]

    @State private var author: Author? = nil
    @State private var title: String = ""
    @State private var pages: Int = 0
    
    var body: some View {
        NewSheet(title: "New Book") {
            Section("Book") {
                TextField("Title", text: $title)
                    .font(.headline)
                TextField("Pages", value: $pages, format: .number)
                
                Picker("Author", selection: $author) {
                    Text("no Author").tag(nil as Author?)
                    ForEach(authors, id: \.self) { author in
                        Text(author.name).tag(author as Author?)
                    }
                }
            }
            
        } action: {
            withAnimation {
                let new = Book(title: title, pages: pages, author: author!)
                _ = try? store.box(for: Book.self).put(new)
            }
        } disabled: {
            author == nil || title.isEmpty
        }
        
    }
}

