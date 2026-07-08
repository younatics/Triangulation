//
//  TriangulationTests.swift
//  TriangulationTests
//
//  Deterministic tests for the Delaunay triangulation core and the vertex model.
//  These run headlessly on the simulator.
//

import XCTest
import CoreGraphics
@testable import Triangulation

@MainActor
final class TriangulationTests: XCTestCase {

    func testVertexEqualityAndPoint() {
        let a = Vertex(x: 1, y: 2)
        let b = Vertex(x: 1, y: 2)
        let c = Vertex(x: 3, y: 4)
        XCTAssertEqual(a, b)
        XCTAssertNotEqual(a, c)
        XCTAssertEqual(a.pointValue(), CGPoint(x: 1, y: 2))
    }

    func testEdgeIsUndirected() {
        let v1 = Vertex(x: 0, y: 0)
        let v2 = Vertex(x: 1, y: 1)
        XCTAssertEqual(Edge(vertex1: v1, vertex2: v2), Edge(vertex1: v2, vertex2: v1))
        // Undirected equality now implies equal hashes (Hashable contract).
        XCTAssertEqual(
            Edge(vertex1: v1, vertex2: v2).hashValue,
            Edge(vertex1: v2, vertex2: v1).hashValue
        )
    }

    func testTriangulateSquareProducesTriangles() {
        let square = [
            Vertex(x: 0, y: 0),
            Vertex(x: 100, y: 0),
            Vertex(x: 100, y: 100),
            Vertex(x: 0, y: 100)
        ]

        let triangles = Delaunay().triangulate(square)

        // A convex quad triangulates into at least two triangles.
        XCTAssertGreaterThanOrEqual(triangles.count, 2)
        // Every emitted triangle has three distinct vertices.
        for triangle in triangles {
            XCTAssertNotEqual(triangle.vertex1, triangle.vertex2)
            XCTAssertNotEqual(triangle.vertex2, triangle.vertex3)
            XCTAssertNotEqual(triangle.vertex1, triangle.vertex3)
        }
    }

    func testTriangulateEmptyInputReturnsNoTriangles() {
        XCTAssertTrue(Delaunay().triangulate([]).isEmpty)
    }
}
