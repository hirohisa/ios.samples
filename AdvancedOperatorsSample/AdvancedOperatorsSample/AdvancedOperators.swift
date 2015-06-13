//
//  AdvancedOperators.swift
//  AdvancedOperatorsSample
//
//  Created by Hirohisa Kawasaki on 6/14/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//
// reference
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html

import Foundation

class Person {

    let name: String
    let score: Int

    init(_ name: String, _ score: Int) {
        self.name = name
        self.score = score
    }
}

extension Person: Printable {

    var description: String {
        return "\(name): \(score)"
    }
}

infix operator <- { associativity left precedence 140 } // precedence 100 - 140

func <- (left: Person, right: Person) -> [Person] {
    return [left, right]
}

func <- (left: [Person], right: Person) -> [Person] {
    var array = left
    array.append(right)
    return array
}