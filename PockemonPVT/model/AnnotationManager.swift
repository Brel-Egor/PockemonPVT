//
//  AnnotationManager.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 22.11.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//
import UIKit
import MapKit
import Foundation


class AnnotationManager{
    var creatures: Creatures?
    weak var mapView: MKMapView?
    
    init(mapView:MKMapView){
        self.mapView = mapView
        
    }
    
    func parsePokemonsJson(){
        let stringUrl =  "\(Constants.Heroku.baseAPIURL)\(Constants.HerokuGet.pokemons)"
        guard let url = URL(string: stringUrl) else { return }
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            guard let data = data else { return }
            do{
                self.creatures = try JSONDecoder().decode(Creatures.self, from: data)
                self.startLoadingAnnotations()
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func startLoadingAnnotations(){
        if let array = creatures{
            for pokemon in array.pocks{
                let annotation = ImageAnnotation(creature: pokemon)
                annotation.coordinate = CLLocationCoordinate2DMake(pokemon.x, pokemon.y)
                DispatchQueue.main.async {
                    self.mapView?.addAnnotation(annotation)
                    self.loadImage(annotation: annotation)
                }
                
            }
        }
        
    }
    
    func loadImage(annotation: ImageAnnotation){
        let stringUrl =  "\(Constants.Heroku.baseAPIURL)/\(Constants.Heroku.smallPictFolder)\(annotation.smallPictUrl!)"
        guard let url = URL(string: stringUrl) else { return }
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            guard let data = data else {
                return
            }
                annotation.image = UIImage(data: data, scale: UIScreen.main.scale)
        }.resume()
    }
    
}


