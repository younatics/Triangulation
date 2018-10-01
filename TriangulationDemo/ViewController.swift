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
        
        let triangleView = TriangulationView(frame: view.bounds, image: imageView.image!)
        view.addSubview(triangleView)
    }
}

