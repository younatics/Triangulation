//
//  Triangle.swift
//  DelaunayTriangulationSwift
//
//  Created by Alex Littlejohn on 2016/01/08.
//  Copyright © 2016 zero. All rights reserved.
//

import CoreGraphics

/// A simple struct representing 3 vertices
struct Triangle {
    
    init(vertex1: Vertex, vertex2: Vertex, vertex3: Vertex) {
        self.vertex1 = vertex1
        self.vertex2 = vertex2
        self.vertex3 = vertex3
    }
    
    let vertex1: Vertex
    let vertex2: Vertex
    let vertex3: Vertex
    
    func v1() -> CGPoint {
        return vertex1.pointValue()
    }
    
    func v2() -> CGPoint {
        return vertex2.pointValue()
    }
    
    func v3() -> CGPoint {
        return vertex3.pointValue()
    }
}
