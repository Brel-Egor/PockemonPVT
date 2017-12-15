//
//  ImageAnnotation.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 01.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class ImageAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var image: UIImage?{
        willSet{
            if let view = self.annotationView {
                view.setImage(image: newValue!)
            }
        }
//        get{
//                return self.image
//        }
//        set{
//            DispatchQueue.main.async {
//                self.image = newValue
//                if let view = self.annotationView {
//                    view.setImage(image: newValue!)
//                }
//            }
//        }
        
    }
    var id: Int?
    var name: String?
    var power: Int?
    var smallPictUrl: String?
    var modelID: String?
    var title: String?
    weak var annotationView: ImageAnnotationView?
    
    init(creature: Pockemon) {
        self.coordinate = CLLocationCoordinate2D.init(latitude: creature.x, longitude: creature.y)
        self.title = creature.name
        self.id = creature.id
        self.name = creature.name
        self.power = creature.power
        self.smallPictUrl = creature.smallPictUrl
        self.modelID = creature.modelID
    }
}
