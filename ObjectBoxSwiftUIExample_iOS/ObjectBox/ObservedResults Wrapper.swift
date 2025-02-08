//
//  ObservedResults Wrapper.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 07.02.25.
//

import SwiftUI
import ObjectBox
import Combine


/// A SwiftUI property wrapper that fetches and automatically updates an array of ObjectBox entities.
///
/// This wrapper fetches records from an ObjectBox database and updates automatically
/// when changes occur. It supports filtering, sorting, and live updates.
///
/// ## Example Usage
///
/// **Fetch all records:**
/// ```swift
/// @ObservedResults var allBooks: [Book]
/// ```
///
/// **Fetch filtered records:**
/// ```swift
/// @ObservedResults(query: { Book.pages > 100 }) var longBooks: [Book]
/// ```
///
/// **Fetch and sort records:**
/// ```swift
/// @ObservedResults(query: { Book.pages > 100 }, orderedBy: Book.title, flags: .descending)
/// var sortedLongBooks: [Book]
/// ```
///
/// - Parameters:
///   - query: A closure that defines the filtering condition. If omitted, all records are returned.
///   - orderedBy: An optional sorting property.
///   - flags: Sorting flags, such as `.descending`. Defaults to `.caseSensitive`.
@propertyWrapper
struct ObservedResults<T: Entity & EntityInspectable & __EntityRelatable & Identifiable>: DynamicProperty where T == T.EntityBindingType.EntityType {
    
    @StateObject private var resultsObserver: ResultsObserver<T>

    var wrappedValue: [T] {
        resultsObserver.results
    }

    var projectedValue: Binding<[T]> {
        Binding(
            get: {
                print("*", self.resultsObserver.results)
                return self.resultsObserver.results
            },
            set: { self.resultsObserver.results = $0 }
        )
    }

    init(query: @escaping () -> QueryCondition<T>? = { nil },
         orderedBy orderProperty: Property<T, String, Void>? = nil,
         flags: OrderFlags = .caseSensitive ) {
        
        _resultsObserver = StateObject(wrappedValue: ResultsObserver(query: query, orderedBy: orderProperty, flags: flags))
    }
}



class ResultsObserver<T: Entity & EntityInspectable & __EntityRelatable & Identifiable>: ObservableObject where T == T.EntityBindingType.EntityType {
    
    @Published var results: [T] = []
    private var query: Query<T>?
    private var observer: Observer?  // ObjectBox Observer

    init(query: @escaping () -> QueryCondition<T>?,
         orderedBy orderProperty: Property<T, String, Void>? = nil,
         flags: OrderFlags = .caseSensitive ) {
        
        do {
            let box = store.box(for: T.self)

            // Create query builder and apply filtering
            var queryBuilder: QueryBuilder<T>
            if let condition = query() {
                queryBuilder = box.query { condition }  // Apply filter if provided
            } else {
                queryBuilder = box.query()  // No filter applied → fetch all records
            }

            // Apply sorting if provided
            if let orderProperty {
                queryBuilder = queryBuilder.ordered(by: orderProperty, flags: flags)
            }

            self.query = try queryBuilder.build()
            
            fetchResults()

            // Subscribe to database changes in ObjectBox
            observer = box.subscribe(dispatchQueue: .main, flags: [.sendInitial]) { [weak self] updatedResults, error in
                if let error = error {
                    print("ObjectBox subscription error: \(error)")
                } else {
                    self?.fetchResults()
                }
            }
        } catch {
            print("Error initializing query for \(T.self): \(error)")
        }
    }

    private func fetchResults() {
        do {
            if let query {
                self.results = try query.find()
            }
        } catch {
            print("Error fetching results for \(T.self): \(error)")
        }
    }

    deinit {
        observer = nil  // Releasing subscription when the observer is deinitialized
    }
}
