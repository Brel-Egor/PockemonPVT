//
//  Pokemon.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 04.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import UIKit
import SceneKit

final class Pokemon: SCNNode {
    
    private static let boxSide: CGFloat = 0.1
    
    init(file: String) {
        super.init()
        initialization(file: file)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization(file:"Squirtl")
    }
    
    private func initialization(file: String) {
        print(file)
        let loadingScene = SCNScene(named: "3d.scnassets/\(file)/\(file).dae")!
        let nodeArray = loadingScene.rootNode.childNodes
        self.position = SCNVector3(x: 0, y: 0, z: 0.05)
        self.scale = SCNVector3(x: 0.1, y:0.1, z:0.1)
        for childNode in nodeArray {
            self.addChildNode(childNode as SCNNode)
        }
        
        //let shape = SCNPhysicsShape(geometry: self.geometry!, options: nil)
        //print(self.geometry)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.physicsBody?.isAffectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionCategory.logos.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.arBullets.rawValue
        
    }
    
    /*func loadNode(file: String) -> SCNNode {
        let loadingObjNode = SCNNode()
        let loadingScene = SCNScene(named: file)!
        let nodeArray = loadingScene.rootNode.childNodes
        loadingObjNode.position = SCNVector3(x: 0, y: 0, z: 0.05)
        loadingObjNode.scale = SCNVector3(x: 0.1, y:0.1, z:0.1)
        for childNode in nodeArray {
            loadingObjNode.addChildNode(childNode as SCNNode)
        }
        
        return loadingObjNode
    }*/
}
