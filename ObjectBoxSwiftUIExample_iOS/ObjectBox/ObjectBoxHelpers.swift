//
//  OBHelpers.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 07.02.25.
//

import Foundation
import ObjectBox


/// Initializes and returns an ObjectBox `Store` with a specified name in the ApplicationSupport directory.
///
/// This function creates the necessary application support directory for storing ObjectBox data,
/// ensuring the database is properly initialized at a persistent location. Ususally only called once at app start.
/// If directory creation or store initialization fails, the function triggers a fatal error.
///
/// ## Example Usage
/// ```swift
/// let store = initStore(name: "MyDatabase")
/// ```
///
/// - Parameter name: The name of the database directory.
/// - Returns: A configured `Store` instance for ObjectBox.
/// - Throws: This function does not return errors; instead, it calls `fatalError` if initialization fails.
func initStore(name: String) -> Store {
    do {
        let appSupport = try FileManager.default.url(for: .applicationSupportDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil,
                                                     create: true)
            .appendingPathComponent(Bundle.main.bundleIdentifier!)
        let directory = appSupport.appendingPathComponent(name)
        try? FileManager.default.createDirectory(at: directory,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
        
        let store = try Store(directoryPath: directory.path)
        return store
    } catch {
        fatalError("Failed to initialize store: \(error)")
    }
}




func loadExampleData() {
    
    do {
        let authorBox = store.box(for: Author.self)
        let bookBox = store.box(for: Book.self)

        let booksEmpty = try bookBox.isEmpty()
        let authorsEmpty = try authorBox.isEmpty()
        
        if booksEmpty && authorsEmpty {
            let author1 = Author(name: "Herman Melville", birthyear: 1819)
            let author2 = Author(name: "Leo Tolstoi", birthyear: 1828)
            let author3 = Author(name: "Henry Miller", birthyear: 1891)
            let author4 = Author(name: "Anais Nin", birthyear: 1903)
            let author5 = Author(name: "Thomas Mann", birthyear: 1875)

            let book1 = Book(title: "Moby Dick", pages: 100, author: author1)

            let book2 = Book(title: "Anna Karenina", pages: 500, author: author2)
            let book3 = Book(title: "War and Peace", pages: 500, author: author2)

            let book4 = Book(title: "Tropic of Cancer", pages: 100, author: author3)
            let book5 = Book(title: "Nexus", pages: 100, author: author3)

            let book6 = Book(title: "A spy in the house of love", pages: 100, author: author4)
            let book7 = Book(title: "Delta of Venus", pages: 100, author: author4)

            let book8 = Book(title: "The Magic Mountain", pages: 300, author: author5)
            let book9 = Book(title: "Death in Venice", pages: 300, author: author5)

            try store.runInTransaction {
                try authorBox.put(author1)
                try authorBox.put(author2)
                try authorBox.put(author3)
                try authorBox.put(author4)
                try authorBox.put(author5)

                try bookBox.put(book1)
                try bookBox.put(book2)
                try bookBox.put(book3)
                try bookBox.put(book4)
                try bookBox.put(book5)
                try bookBox.put(book6)
                try bookBox.put(book7)
                try bookBox.put(book8)
                try bookBox.put(book9)
            }
        }
    } catch {
        print("Error loading sample data: \(error)")
    }
}
