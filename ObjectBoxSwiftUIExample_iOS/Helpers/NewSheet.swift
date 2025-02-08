//
//  NewSheet
//
//  Created by Christoph Rohrer on 06.02.25.
//

import SwiftUI

/// A reusable sheet and form implementation for adding new items in SwiftUI.
///
/// `NewSheet` provides a standardized way to present a form inside a sheet,
/// allowing users to input data and confirm or cancel their actions.
///
/// ## Example Usage
///
/// **Using `NewSheet` to add a new `Book`:**
/// ```swift
/// struct AddBookView: View {
///     @State private var title: String = ""
///
///     var body: some View {
///         NewSheet(title: "New Book", content: {
///             TextField("Title", text: $title)
///         }, action: {
///             print("Saving book: \(title)")
///         })
///     }
/// }
/// ```
///
/// - Parameters:
///   - title: The title of the sheet, displayed in the navigation bar.
///   - content: A `ViewBuilder` closure providing the form content.
///   - action: A closure executed when the user confirms the action.
///   - disabled: An optional closure returning `true` if the confirm button should be disabled (default: `{ false }`).
struct NewSheet<V: View>: View {
    
    internal init(title: String, @ViewBuilder content: @escaping () -> V, action: @escaping () -> Void, disabled: @escaping () -> Bool = { false }) {
        self.title = title
        self.content = content
        self.action = action
        self.disabled = disabled
    }
    
    let title: String
    let content: () -> V
    let action: () -> Void
    var disabled: () -> Bool = { false }
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Form {
                    content()
                }
                .formStyle(.grouped)
                .scrollDisabled(true)
                
            }
            .frame(minWidth: 400, minHeight: 300)
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction ) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction ) {
                    Button("OK") {
                        action()
                        dismiss()
                    }
                    .disabled(disabled())
                }
            }
            .navigationTitle(title)
        }
    }
}
