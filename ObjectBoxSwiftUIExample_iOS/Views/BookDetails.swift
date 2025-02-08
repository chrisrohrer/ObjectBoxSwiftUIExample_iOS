//
//  BookDetails.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 26.01.25.
//

import SwiftUI
import ObjectBox


struct BookDetails: View {
    
    @ObservedModel var book: Book
    
    @ObservedResults(orderedBy: Author.name)
    var authors: [Author]

    @State private var selectedAuthor: Author? = nil
    
    var body: some View {
        
        Form {
            TextField("Title", text: $book.title)
            TextField("Pages", value: $book.pages, format: .number.grouping(.never))

            Picker("Author", selection: $book.author.target) {
                Text("no Author").tag(nil as Author?)
                ForEach(authors, id: \.self) { author in
                    Text(author.name).tag(author as Author?)
                }
            }
        }
        .navigationTitle(book.title)
        
    }
}


