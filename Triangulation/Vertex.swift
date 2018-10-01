//
//  Vertex.swift
//  DelaunayTriangulationSwift
//
//  Created by Alex Littlejohn on 2016/01/08.
//  Copyright © 2016 zero. All rights reserved.
//

import CoreGraphics

struct Vertex: Hashable {
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    func pointValue() -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    let x: Double
    let y: Double
}

extension Vertex: Equatable { 
    static public func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
