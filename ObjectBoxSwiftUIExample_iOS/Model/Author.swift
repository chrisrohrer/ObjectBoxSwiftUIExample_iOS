//
//  Author.swift
//  ObjectBoxTest
//
//  Created by Christoph Rohrer on 26.01.25.
//

import Foundation
import ObjectBox

// objectbox: entity
class Author: Identifiable, Hashable {
            
    var id: Id = 0

    var name: String = ""
    var birthyear: Int = 1900
    
    // objectbox: backlink = "author"
    var books: ToMany<Book> = nil


    // Inits
    
    init() {} // Used by ObjectBox
    
    init(name: String = "", birthyear: Int = 1900) {
        self.name = name
        self.birthyear = birthyear
    }
    
    // Hashable Conformance for Picker
    static func == (lhs: Author, rhs: Author) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(birthyear)
    }


}



