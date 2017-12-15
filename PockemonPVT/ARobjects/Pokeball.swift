//
//  Pokeball.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 04.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import UIKit
import SceneKit

final class Pokeball: SCNNode {
    
    private static let sphereRadius: CGFloat = 0.025
    
    override init() {
        super.init()
        initialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
        
    }
    
    private func initialization() {
        
        let arKitBox = SCNSphere(radius: Pokeball.sphereRadius)
        self.geometry = arKitBox
        let shape = SCNPhysicsShape(geometry: arKitBox, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        self.physicsBody?.categoryBitMask = CollisionCategory.arBullets.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.logos.rawValue

        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        self.geometry?.materials  = [material]
        
    }
    
}
