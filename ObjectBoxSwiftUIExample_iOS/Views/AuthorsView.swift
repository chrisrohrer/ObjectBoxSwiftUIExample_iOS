//
//  AutorenView.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 26.01.25.
//

import SwiftUI
import ObjectBox


struct AuthorsView: View {
    
    @ObservedResults(orderedBy: Author.name)
    private var authors: [Author]

    @State private var showNewSheet = false

    @AppStorage("selectedAuthor")
    var selectedAuthor: Author.ID?
    
    var body: some View {
        
        NavigationSplitView {
            List(selection: $selectedAuthor) {
                ForEach(authors) { author in
                    authorListCell(author)
                        .contextMenu {
                            Button("Delete Author") {
                                deleteItem(author)
                            }
                        }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Authors")
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem(placement: .primaryAction) {
                    Button("Add Author", systemImage: "plus.circle") { showNewSheet = true }
                        .labelStyle(.titleAndIcon)
                }
            }

        } detail: {
            if let author = authors[selectedAuthor] {
                AuthorDetails(author: author)
                    .id(author.id)
            } else {
                Text("Choose an author")
            }
        }

        .sheet(isPresented: $showNewSheet) {
            NewAuthorSheet()
        }
    }
    
    // single Author cell in list
    private func authorListCell(_ author: Author) -> some View {
        VStack(alignment: .leading) {
            Text(author.name)
                .font(.headline)
            Group {
                Text(author.birthyear.formatted(.number.grouping(.never)))
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .badge(author.books.count)
    }

    
    private func deleteItems(offsets: IndexSet) {
        guard let index = offsets.first else { return }
        withAnimation {
            let author = authors[index]
            _ = try? store.box(for: Author.self).remove(author)
        }
    }

    private func deleteItem(_ author: Author) {
        withAnimation {
            _ = try? store.box(for: Author.self).remove(author)
        }
    }

}


