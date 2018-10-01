//
//  TriangleView.swift
//  DelaunayTriangulationSwift
//
//  Created by Alex Littlejohn on 2016/01/08.
//  Copyright © 2016 zero. All rights reserved.
//

import UIKit
import GameplayKit

public class TriangulationView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience public init(frame: CGRect, image: UIImage, cellSize: CGFloat = 30) {
        self.init(frame: frame)
        
        let vertices = generateVertices(bounds.size, cellSize: cellSize)
        let triangles = Delaunay().triangulate(vertices)
        
        for triangle in triangles {
            let triangleLayer = CAShapeLayer()
            let path = triangle.toPath()
            triangleLayer.path = path
            let color = getPixelColor(cropImage(image, toRect: path.boundingBox))
            triangleLayer.fillColor = color.cgColor
            triangleLayer.backgroundColor = UIColor.clear.cgColor
            layer.addSublayer(triangleLayer)
        }
    }
    
    func cropImage(_ imageToCrop:UIImage, toRect rect:CGRect) -> UIImage? {
        if let imageRef = imageToCrop.cgImage?.cropping(to: rect) {
            return UIImage(cgImage:imageRef)
        } else {
            return nil
        }
    }
    
    func getPixelColor(_ image:UIImage?, _ point: CGPoint = CGPoint.zero) -> UIColor {
        guard let image = image,
            let cgImageData = image.cgImage?.dataProvider?.data,
            let pixelData = CGDataProvider(data: cgImageData)?.data else { return UIColor.clear }
        
        let data = CFDataGetBytePtr(pixelData)!
        let x = Int(point.x)
        let y = Int(point.y)
        let index = Int(image.size.width) * y + x
        let expectedLengthA = Int(image.size.width * image.size.height)
        let (expectedLengthRGB, expectedLengthRGBA) = (3 * expectedLengthA, 4 * expectedLengthA)
        let numBytes = CFDataGetLength(pixelData)
        
        switch numBytes {
        case expectedLengthA:
            return UIColor(red: 0, green: 0, blue: 0, alpha: CGFloat(data[index])/255.0)
        case expectedLengthRGB:
            return UIColor(red: CGFloat(data[3*index])/255.0, green: CGFloat(data[3*index+1])/255.0, blue: CGFloat(data[3*index+2])/255.0, alpha: 1.0)
        case expectedLengthRGBA:
            return UIColor(red: CGFloat(data[4*index])/255.0, green: CGFloat(data[4*index+1])/255.0, blue: CGFloat(data[4*index+2])/255.0, alpha: CGFloat(data[4*index+3])/255.0)
        default:
            return UIColor.clear
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Generate set of vertices for our triangulation to use
    func generateVertices(_ size: CGSize, cellSize: CGFloat, variance: CGFloat = 0.75, seed: UInt64 = numericCast(arc4random())) -> [Vertex] {
        let cellsX = (size.width + 4 * cellSize) / cellSize
        let cellsY = (size.height + 4 * cellSize) / cellSize
        
        let bleedX = ((cellsX * cellSize) - size.width)/2
        let bleedY = ((cellsY * cellSize) - size.height)/2
        
        let _variance = cellSize * variance / 4
        
        var points = [Vertex]()
        let minX = -bleedX
        let maxX = size.width + bleedX
        let minY = -bleedY
        let maxY = size.height + bleedY
        
        let generator = GKLinearCongruentialRandomSource(seed: seed)
        for i in stride(from: minX, to: maxX, by: cellSize) {
            for j in stride(from: minY, to: maxY, by: cellSize) {
                let x = i + CGFloat.random(cellSize / 2, cellSize * 2)/2 + CGFloat(generator.nextUniform()) + CGFloat.random(-_variance, _variance)
                let y = j + CGFloat.random(cellSize / 2, cellSize * 2)/2 + CGFloat(generator.nextUniform()) + CGFloat.random(-_variance, _variance)

                points.append(Vertex(x: Double(x), y: Double(y)))
            }
        }
        return points
    }
}

