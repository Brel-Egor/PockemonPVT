//
//  CollisionCategory.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 04.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import Foundation

struct CollisionCategory: OptionSet {
    let rawValue: Int
    static let arBullets  = CollisionCategory(rawValue: 1 << 0)
    static let logos = CollisionCategory(rawValue: 1 << 1)
}
