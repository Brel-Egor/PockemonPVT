//
//  ViewController.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 21.11.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PokeMapViewController: UIViewController,MKMapViewDelegate {

    var zoomInButton: UIButton!
    var changeTypeButton: UIButton!
    
    var mapView: MKMapView!
    var annotationManager: AnnotationManager!
    var userLocation: CLLocation?
    let locationManager = CLLocationManager()
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.mapView = MKMapView()
        self.mapView.delegate = self
        self.annotationManager = AnnotationManager(mapView: self.mapView)
        mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
        mapView.showsUserLocation = true
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        self.zoomInButton = UIButton.init(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
        self.zoomInButton.setTitle("Zoom in", for: .normal)
        self.zoomInButton.setTitleColor(.blue, for: .normal)
        self.zoomInButton.addTarget(self, action: #selector(self.zoomInPressed), for: .touchUpInside)
        
        self.changeTypeButton = UIButton.init(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
        self.changeTypeButton.setTitle("Change type", for: .normal)
        self.changeTypeButton.setTitleColor(.blue, for: .normal)
        self.changeTypeButton.addTarget(self, action: #selector(self.changeTypePressed), for: .touchUpInside)
        self.view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.annotationManager.parsePokemonsJson()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupUI(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        changeTypeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        self.view.addSubview(zoomInButton)
        self.view.addSubview(changeTypeButton)
        self.addConstraints()
    }
    
    func addConstraints(){
        let leadingMVConstraint = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        
        let trailingMVConstraint = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        
        let topMVConstraint = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
        
        let bottomMVConstraint = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -70)
        self.view.addConstraints([leadingMVConstraint,trailingMVConstraint,bottomMVConstraint,topMVConstraint])
        
        let leadingZBConstraint = NSLayoutConstraint(item: zoomInButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        
        let widthZBConstraint = NSLayoutConstraint(item: zoomInButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: self.view.frame.width / 3 - 40)
        
        let topZBConstraint = NSLayoutConstraint(item: zoomInButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: mapView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 20)
        
        let heightZBConstraint = NSLayoutConstraint(item: zoomInButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 30)
        
        self.view.addConstraints([leadingZBConstraint,widthZBConstraint,heightZBConstraint,topZBConstraint])
        
        let trailingCBConstraint = NSLayoutConstraint(item: changeTypeButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        
        let widthCBConstraint = NSLayoutConstraint(item: changeTypeButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: self.view.frame.width / 3 - 20)
        
        let topCBConstraint = NSLayoutConstraint(item: changeTypeButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: mapView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 20)
        
        let heightCBConstraint = NSLayoutConstraint(item: changeTypeButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 30)
        
        self.view.addConstraints([trailingCBConstraint,widthCBConstraint,heightCBConstraint,topCBConstraint])
    }
    
    @objc func zoomInPressed(){
        
        let userlocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance((userlocation.location?.coordinate)!, 2000, 2000)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func changeTypePressed(){
        if mapView.mapType == .standard{
            mapView.mapType = .satellite
        }else{
            mapView.mapType = .standard
        }
    }
    
    func setAlert(annotation: ImageAnnotation){
        self.mapView.removeAnnotation(annotation)
        let popoverView = PopoverView(superView: self.view)
        popoverView.setData(annotation: annotation)
        self.view.addSubview(popoverView)
        popoverView.animateIn()
        PokemonTableDelegate.sharedInstance.createNewEntity(annotation: annotation)
    }
    
}

extension PokeMapViewController {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.userLocation = userLocation.location
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {  //Handle user location annotation..
            return nil
        }
        
        if !annotation.isKind(of: ImageAnnotation.self) {  //Handle non-ImageAnnotations..
            var pinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "DefaultPinView")
            if pinAnnotationView == nil {
                pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "DefaultPinView")
            }
            return pinAnnotationView
        }
        //var view: ImageAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "imageAnnotation") as? ImageAnnotationView
       // if view == nil {
            let view = ImageAnnotationView(annotation: annotation, reuseIdentifier: "imageAnnotation")
            (annotation as! ImageAnnotation).annotationView = view
            view.canShowCallout = true
            view.detailCalloutAccessoryView = ImageAnnotationCalloutView(mapController: self, annotation: annotation)
       // } else {
        //    return view
       // }
        return view
    }
}
