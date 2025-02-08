//
//  Observed Wrapper.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 07.02.25.
//

import Foundation
import SwiftUI
import Combine
import ObjectBox



/// A property wrapper that observes and updates an ObjectBox entity in a SwiftUI view.
///
/// This wrapper allows a SwiftUI view to observe changes to a single ObjectBox entity,
/// automatically reflecting updates in the UI. Changes to the entity are **automatically saved**
/// to the ObjectBox database when modified.
///
/// ## Example Usage
///
/// **Observe and edit a `Book` entity:**
///
/// In parent view:
/// ```swift
/// List(books) {
///    NavigationLink {
///        BookDetailView(book: book)
///    } label: {
///        Text(book.title)
///    }
/// }
/// ```
///
/// In subview:
/// ```swift
/// struct BookDetailView: View {
///     @ObservedModel var book: Book
///
///     var body: some View {
///         VStack {
///             TextField("Title", text: $book.title)
///                 .textFieldStyle(RoundedBorderTextFieldStyle())
///         }
///         .padding()
///     }
/// }
/// ```
///
/// - Parameter wrappedValue: The ObjectBox entity to be observed and modified.
@propertyWrapper
struct ObservedModel<T: Entity & __EntityRelatable & EntityInspectable & Identifiable>: DynamicProperty where T == T.EntityBindingType.EntityType
{
    @StateObject private var observableModel: ObservableModel<T>
    
    var wrappedValue: T {
        get { observableModel.value }
        nonmutating set {
            observableModel.value = newValue
//            observableModel.update()
        }
    }
    
    var projectedValue: Binding<T> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    init(wrappedValue: T) {
        _observableModel = StateObject(wrappedValue: ObservableModel(value: wrappedValue))
    }
    
    // Initializer with wrappedValue and select string
    init(wrappedValue: T, select: String?) {
        let model = ObservableModel<T>(value: wrappedValue)
        _observableModel = StateObject(wrappedValue: model)
    }
}


// ObservableObject class to wrap the model
final class ObservableModel<T: Entity & __EntityRelatable & EntityInspectable & Identifiable>: ObservableObject where T == T.EntityBindingType.EntityType
{
    
    @Published var value: T {
        didSet {
            save()
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    private func save() {
        do {
            let box = store.box(for: T.self)
            try box.put(value)
        } catch {
            print("Error saving \(T.self): \(error)")
        }
    }

}
