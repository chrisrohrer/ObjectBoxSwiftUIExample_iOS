//
//  AutorDetails.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 26.01.25.
//

import SwiftUI
import ObjectBox


struct AuthorDetails: View {
    
    @ObservedModel var author: Author
    
    @State private var booksLoaded = false  // Track when books are loaded

    var body: some View {
        
        Form {
            TextField("Name", text: $author.name)
            TextField("Birthyear", value: $author.birthyear, format: .number.grouping(.never))
            
            Section("Books") {
                if booksLoaded {
                    
                    List(author.books.sorted { $0.title < $1.title }) { book in
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                            Text(book.author.target?.name ?? "unknown")
                            Text(book.pages.formatted())
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .navigationTitle(author.name)
        
        // Workaround to prevent crash when books are deleted
        .onAppear {
            author.books.reset()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                booksLoaded = true
            }
        }

    }
}


