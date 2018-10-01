//
//  Circumcircle.swift
//  DelaunayTriangulationSwift
//
//  Created by Alex Littlejohn on 2016/01/08.
//  Copyright © 2016 zero. All rights reserved.
//

/// Represents a bounding circle for a set of 3 vertices
internal struct Circumcircle {
    let vertex1: Vertex
    let vertex2: Vertex
    let vertex3: Vertex
    let x: Double
    let y: Double
    let rsqr: Double
}
