//
//  ARViewController.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 02.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import UIKit
import ARKit

class ARViewController: UIViewController,ARSCNViewDelegate,SCNPhysicsContactDelegate {

    var isCatched = false
    weak var annotation: ImageAnnotation!
    weak var previousVC: PokeMapViewController!
    var sceneView: ARSCNView!
    var backButton: UIButton!
    
    init(annotation: ImageAnnotation,previousVC:PokeMapViewController){
        super.init(nibName: nil, bundle: nil)
        self.previousVC = previousVC
        self.backButton = UIButton(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
        self.backButton.setTitle("Back", for: .normal)
        self.backButton.setTitleColor(.blue, for: .normal)
        self.backButton.addTarget(self, action: #selector(self.backPressed), for: .touchUpInside)
        self.annotation = annotation
        self.sceneView = ARSCNView.init()
        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        let scene = SCNScene()
        sceneView.scene = scene
    
        let pokemon = Pokemon.init(file: self.annotation.modelID!)
        pokemon.position = SCNVector3(0, -0.7, -1)
       
        scene.rootNode.addChildNode(pokemon)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
        sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func setupUI(){
        self.view.backgroundColor = .white
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sceneView)
        self.view.addSubview(backButton)
        self.addConstraints()
    }
    
    func addConstraints(){
        let leadingSVConstraint = NSLayoutConstraint(item: sceneView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        
        let trailingSVConstraint = NSLayoutConstraint(item: sceneView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        
        let topSVConstraint = NSLayoutConstraint(item: sceneView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
        
        let bottomSVConstraint = NSLayoutConstraint(item: sceneView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -70)
        self.view.addConstraints([leadingSVConstraint,trailingSVConstraint,bottomSVConstraint,topSVConstraint])
        
        let leadingBBConstraint = NSLayoutConstraint(item: backButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        
        let widthBBConstraint = NSLayoutConstraint(item: backButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: self.view.frame.width / 3 - 40)
        
        let topBBConstraint = NSLayoutConstraint(item: backButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: sceneView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 20)
        
        let heightBBConstraint = NSLayoutConstraint(item: backButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 30)
        
        self.view.addConstraints([leadingBBConstraint,widthBBConstraint,heightBBConstraint,topBBConstraint])
    }
    
    @objc func tapAction() {
        shoot()
    }
    
    func shoot(){
        let pokeball = Pokeball()
        let (direction, position) = cameraVector()
        pokeball.position = position
        let bulletDirection = direction
        pokeball.physicsBody?.applyForce(bulletDirection, asImpulse: true)
        sceneView.scene.rootNode.addChildNode(pokeball)
        
    }
    
    func cameraVector() -> (SCNVector3,SCNVector3){
        
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4.init(frame.camera.transform)
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43)
            return (dir, pos)
        }
        return (SCNVector3(0, 0, 0), SCNVector3(0, 0, 0))
    }
    
    @objc func backPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ARViewController{
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        guard let nodeABitMask = contact.nodeA.physicsBody?.categoryBitMask,
            let nodeBBitMask = contact.nodeB.physicsBody?.categoryBitMask,
            nodeABitMask & nodeBBitMask == CollisionCategory.logos.rawValue & CollisionCategory.arBullets.rawValue else {
                return
        }
        if !isCatched {
            isCatched = true
            contact.nodeB.removeFromParentNode()
            DispatchQueue.main.async {
                self.previousVC.setAlert(annotation: self.annotation)
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
