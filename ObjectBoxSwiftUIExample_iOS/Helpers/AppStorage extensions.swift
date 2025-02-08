//
//  AppStorage extensions.swift
//
//  Created by Christoph Rohrer on 06.02.25.
//

import Foundation
import ObjectBox

// helpers to make @AppStorage work with Entity.ID, mainly for persisting list selections

extension UInt64:  @retroactive RawRepresentable {
    
    public typealias RawValue = String
    
    public var rawValue: String {
        return String(self)
    }
    
    public init?(rawValue: String) {
        self = UInt64(rawValue)!
    }
}




extension UInt64?:  @retroactive RawRepresentable {
    
    public typealias RawValue = String
    
    public var rawValue: String {
        if self == nil  {
            return "?"
        } else {
            return String(self!)
        }
    }
    
    public init?(rawValue: String) {
        self = UInt64(rawValue)
    }
}


extension Set: @retroactive RawRepresentable where Element == Int? {
    
    public typealias RawValue = String
    
    public var rawValue: String {
        self.reduce("") { old, element in
            if let element {
                return old + String(element) + ";"
            } else {
                return old + "?;"
            }
        }
    }
    
    public init?(rawValue: String) {
        let array = rawValue.components(separatedBy: ";").compactMap { Int($0) ?? nil }
        self = Set(array)
    }
}
