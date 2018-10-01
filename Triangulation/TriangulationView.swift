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
        commonInit()
        
    }
    
    convenience public init(frame: CGRect, image: UIImage) {
        self.init(frame: frame)
        
        let vertices = generateVertices(bounds.size, cellSize: 20)
        let triangles = Delaunay().triangulate(vertices)
        
        for triangle in triangles {
            let triangleLayer = CAShapeLayer()
            let path = triangle.toPath()
            triangleLayer.path = path
            let color = getPixelColor(cropImage(imageToCrop: image, toRect: path.boundingBox), CGPoint.zero)
            triangleLayer.fillColor = color?.cgColor
            triangleLayer.backgroundColor = UIColor.clear.cgColor
            layer.addSublayer(triangleLayer)
        }
    }
    
    func cropImage(imageToCrop:UIImage, toRect rect:CGRect) -> UIImage? {
        if let imageRef = imageToCrop.cgImage?.cropping(to: rect) {
            return UIImage(cgImage:imageRef)
        } else {
            return nil
        }
    }
    
    func getPixelColor(_ image:UIImage?, _ point: CGPoint) -> UIColor? {
        guard let image = image else { return nil }
        let cgImage : CGImage = image.cgImage!
        guard let pixelData = CGDataProvider(data: (cgImage.dataProvider?.data)!)?.data else {
            return UIColor.clear
        }
        let data = CFDataGetBytePtr(pixelData)!
        let x = Int(point.x)
        let y = Int(point.y)
        let index = Int(image.size.width) * y + x
        let expectedLengthA = Int(image.size.width * image.size.height)
        let expectedLengthRGB = 3 * expectedLengthA
        let expectedLengthRGBA = 4 * expectedLengthA
        let numBytes = CFDataGetLength(pixelData)
        switch numBytes {
        case expectedLengthA:
            return UIColor(red: 0, green: 0, blue: 0, alpha: CGFloat(data[index])/255.0)
        case expectedLengthRGB:
            return UIColor(red: CGFloat(data[3*index])/255.0, green: CGFloat(data[3*index+1])/255.0, blue: CGFloat(data[3*index+2])/255.0, alpha: 1.0)
        case expectedLengthRGBA:
            return UIColor(red: CGFloat(data[4*index])/255.0, green: CGFloat(data[4*index+1])/255.0, blue: CGFloat(data[4*index+2])/255.0, alpha: CGFloat(data[4*index+3])/255.0)
        default:
            // unsupported format
            return UIColor.clear
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped() {
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
        
    override public func layoutSubviews() {
        super.layoutSubviews()
        
//        let vertices = generateVertices(bounds.size, cellSize: 40)
//        let triangles = Delaunay().triangulate(vertices)
//
//        for triangle in triangles {
//            let triangleLayer = CAShapeLayer()
//            triangleLayer.path = triangle.toPath()
//            triangleLayer.fillColor = UIColor().randomColor().withAlphaComponent(0.4).cgColor
//            triangleLayer.backgroundColor = UIColor.clear.cgColor
//            layer.addSublayer(triangleLayer)
//        }
    }
    
    /// Generate set of vertices for our triangulation to use
    func generateVertices(_ size: CGSize, cellSize: CGFloat, variance: CGFloat = 0.75, seed: UInt64 = numericCast(arc4random())) -> [Vertex] {
        var cellSize = cellSize

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
        
        print("minX: \(minX)")
        print("maxX: \(maxX)")
        print("minY: \(minY)")
        print("maxY: \(maxY)")
        
        let generator = GKLinearCongruentialRandomSource(seed: seed)
        for i in stride(from: minX, to: maxX, by: cellSize) {
            for j in stride(from: minY, to: maxY, by: cellSize) {
                cellSize = CGFloat.random(in: 5 ..< 60)

                let x = i + cellSize/2 + CGFloat(generator.nextUniform()) + CGFloat.random(-_variance, _variance)
                let y = j + cellSize/2 + CGFloat(generator.nextUniform()) + CGFloat.random(-_variance, _variance)

                points.append(Vertex(x: Double(x), y: Double(y)))
            }
        }
        
        return points
    }
}

extension UIImage {
    open func pickColor() -> UIColor {
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        
        let context = CIContext(options: nil)
        let cgImg = context.createCGImage(CoreImage.CIImage(cgImage: self.cgImage!), from: CoreImage.CIImage(cgImage: self.cgImage!).extent)
        
        let inputImage = CIImage(cgImage: cgImg!)
        let extent = inputImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: inputExtent])!
        let outputImage = filter.outputImage!
        let outputExtent = outputImage.extent
        assert(outputExtent.size.width == 1 && outputExtent.size.height == 1)
        
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
        
        let result = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
        return result
    }
    
    open func pickColorHexstring() -> String {
        let color = self.pickColor()
        let hexString = String(format: "%02X%02X%02X",
                               Int((color.cgColor.components?[0])! * 255.0),
                               Int((color.cgColor.components?[1])! * 255.0),
                               Int((color.cgColor.components?[2])! * 255.0))
        return hexString
        
    }
    
}
