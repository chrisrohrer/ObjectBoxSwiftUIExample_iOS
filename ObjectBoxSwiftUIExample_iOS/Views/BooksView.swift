//
//  AutorenView.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 26.01.25.
//

import SwiftUI
import ObjectBox


struct BooksView: View {
    
    @ObservedResults(orderedBy: Book.title)
    private var books: [Book]

    @State private var showNewSheet = false

    @AppStorage("selectedBook")
    var selectedBook: Book.ID?

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedBook) {
                
                Button("Create 50 Dummy Books", systemImage: "plus.circle.dashed") {
                    createDummyBooks()
                }
                .labelStyle(.titleAndIcon)
                .padding(.vertical)

                ForEach(books) { book in
                    bookListCell(book)
                        .contextMenu {
                            Button("Delete Book") {
                                deleteItem(book)
                            }
                        }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Books")
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem(placement: .primaryAction) {
                    Button("Add book", systemImage: "plus.circle") { showNewSheet = true }
                }
            }

        } detail: {
            if let book = books[selectedBook] {
                BookDetails(book: book)
                    .id(book.id)
            } else {
                Text("Select a book")
            }
        }
        
        .sheet(isPresented: $showNewSheet) {
            NewBookSheet()
        }
    }
    
    // single Book cell in list
    private func bookListCell(_ book: Book) -> some View {
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.author.target?.name ?? "unbekannt")
                Text(book.pages.formatted())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
    }

    
    private func deleteItems(offsets: IndexSet) {
        guard let index = offsets.first else { return }
        withAnimation {
            let author = books[index]
            _ = try? store.box(for: Book.self).remove(author)
        }
    }

    private func deleteItem(_ book: Book) {
        withAnimation {
            let author = book.author.target
            _ = try? store.box(for: Book.self).remove(book)
            author?.books.reset() // try to fix delete problem on ToMany of Author.books
        }
    }
    
    private func createDummyBooks() {
        let authors = try! store.box(for: Author.self).all()
        
        var newbooks: [Book] = []
        for nr in 1...50 {
            let author = authors.randomElement()!
            let newbook = Book(title: "Book \(nr)", pages: Int.random(in: 50...500), author: author)
            newbooks.append(newbook)
        }
        _ = try? store.box(for: Book.self).put(newbooks)
        for author in authors {
            author.books.reset()
        }
    }

}

