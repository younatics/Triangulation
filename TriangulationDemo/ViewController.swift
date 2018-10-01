//
//  ViewController.swift
//  TriangulationDemo
//
//  Created by Seungyoun Yi on 01/10/2018.
//  Copyright © 2018 Seungyoun Yi. All rights reserved.
//

import UIKit
import Triangulation

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let croppedImage = cropImage(imageToCrop: imageView.image!, toRect: self.view.bounds)
        let triangleView = TriangulationView(frame: view.bounds, image: croppedImage!, cellSize: 30)
        view.addSubview(triangleView)
    }
    
    func cropImage(imageToCrop:UIImage, toRect rect:CGRect) -> UIImage? {
        if let imageRef = imageToCrop.cgImage?.cropping(to: rect) {
            return UIImage(cgImage:imageRef)
        } else {
            return nil
        }
    }

}

