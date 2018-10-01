//
//  Hash.swift
//  DelaunaySwift
//
//  Created by Volodymyr Boichentsov on 21/08/2017.
//  Copyright © 2017 zero. All rights reserved.
//

import Foundation
 
func hash_combine(seed: inout UInt, value: UInt) {
    let tmp = value &+ 0x9e3779b9 &+ (seed << 6) &+ (seed >> 2)
    seed ^= tmp
}
