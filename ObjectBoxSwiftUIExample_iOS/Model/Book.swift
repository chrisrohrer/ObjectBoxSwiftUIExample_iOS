//
//  Kunde.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 26.01.25.
//

import Foundation
import ObjectBox

// objectbox: entity
class Book: Identifiable {
    
    var id: Id = 0

    var title: String = ""
    var pages: Int = 0
    var notes: String = ""

    var author: ToOne<Author> = nil
    
    
    // Inits
    
    init() {} // Used by ObjectBox

    init(title: String = "", pages: Int = 0, author: Author?) {
        self.title = title
        self.pages = pages
        self.author.target = author
    }
    
//    // Hashable Conformance for Picker etc.
//    static func == (lhs: Book, rhs: Book) -> Bool {
//        lhs.id == rhs.id
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//        hasher.combine(title)
//        hasher.combine(pages)
//    }

    
}


