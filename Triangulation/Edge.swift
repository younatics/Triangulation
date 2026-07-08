//
//  Edge.swift
//  DelaunaySwift
//
//  Created by Alex Littlejohn on 2016/04/07.
//  Copyright © 2016 zero. All rights reserved.
//

struct Edge {
    let vertex1: Vertex
    let vertex2: Vertex
}

extension Edge: Equatable {
    static func ==(lhs: Edge, rhs: Edge) -> Bool {
        return lhs.vertex1 == rhs.vertex1 && lhs.vertex2 == rhs.vertex2 || lhs.vertex1 == rhs.vertex2 && lhs.vertex2 == rhs.vertex1
    }
}

extension Edge: Hashable {
    func hash(into hasher: inout Hasher) {
        // Edges are undirected (a-b == b-a), so hash the two vertices
        // commutatively; otherwise equal edges could hash differently and
        // violate the Hashable contract.
        hasher.combine(vertex1.hashValue ^ vertex2.hashValue)
    }
}
