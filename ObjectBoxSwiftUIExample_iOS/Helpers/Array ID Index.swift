//
//  Array ID Index.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 07.02.25.
//

import Foundation

// helpers to address array elements via subscript using the Entity.ID
// e.g. let book = books[selectedBook] – where selectedBook: Book.ID?

public extension Array where Array.Element: Identifiable {
    
    subscript(elementID: Element.ID?) -> Element? {
        if let elementID, let element = self.first(where: { $0.id == elementID }) {
            return element
        }
        return nil
    }
}


public extension Collection where Element: Identifiable {
    
    subscript(elementID: Element.ID?) -> Element? {
        if let element = self.first(where: {$0.id == elementID}) {
            return element
        } else {
            return nil
        }
    }
    
    func index(matching element: Element) -> Self.Index? {
        firstIndex(where: { $0.id == element.id })
    }
}


public extension RangeReplaceableCollection where Element: Identifiable {

    subscript(_ element: Element) -> Element {
         get {
             if let index = index(matching: element) {
                 return self[index]
             } else {
                 return element
             }
         }
         set {
             if let index = index(matching: element) {
                 replaceSubrange(index...index, with: [newValue])
             }
         }
     }

}
