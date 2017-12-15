//
//  AnnotationCalloutView.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 01.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
class ImageAnnotationCalloutView: UIView{
    var catchButton: UIButton!
    weak var mapController: PokeMapViewController!
    weak var annotation: ImageAnnotation!
    
    init(mapController:PokeMapViewController,annotation:MKAnnotation){
        super.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.mapController = mapController
        self.annotation = annotation as! ImageAnnotation
        catchButton = UIButton()
        self.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI(){
        self.translatesAutoresizingMaskIntoConstraints = false
        let viewWidthConstr =  NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 120)
        let viewHeightConstr =  NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 30)
        self.addConstraints([viewWidthConstr,viewHeightConstr])
        
        catchButton.translatesAutoresizingMaskIntoConstraints = false
        catchButton.backgroundColor = .blue
        catchButton.setTitle("Catch", for: .normal)
        catchButton.layer.cornerRadius = 5
        catchButton.titleLabel?.textColor = UIColor.white
        catchButton.addTarget(self, action: #selector(catchButtonPressed), for: .touchUpInside)
        
        self.addSubview(catchButton)
        let leadingCBConstraint = NSLayoutConstraint(item: catchButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 2)
        let trailingCBConstraint = NSLayoutConstraint(item: catchButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -2)
        let heightCBConstraint = NSLayoutConstraint(item: catchButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 30)
        let bottomCBConstraint = NSLayoutConstraint(item: catchButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -2)
        
    self.addConstraints([leadingCBConstraint,trailingCBConstraint,heightCBConstraint,bottomCBConstraint])
    }
    
    @objc func catchButtonPressed(){
        if let userCoordinate = self.mapController.userLocation{
            if userCoordinate.distance(from: CLLocation(latitude: self.annotation.coordinate.latitude, longitude: self.annotation.coordinate.longitude)) > 0 {
                let annotation = self.mapController.mapView.selectedAnnotations[0] as! ImageAnnotation
                //let VC = ARViewController(annotation:annotation) //что за дичь?!!!!!!!
                //self.mapController.present(VC, animated: true, completion: nil)
                self.mapController.present(ARViewController(annotation:annotation,previousVC:mapController), animated: true, completion: nil)
            } else {
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.05
                animation.repeatCount = 4
                animation.autoreverses = true
                animation.fromValue = NSValue(cgPoint:CGPoint(x:self.center.x - 10,y:self.center.y))
                animation.toValue = NSValue(cgPoint:CGPoint(x:self.center.x + 10,y:self.center.y))
                self.layer.add(animation, forKey: "position")
                
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
