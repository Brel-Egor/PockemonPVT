//
//  PokemonTableDelegate.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 09.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import UIKit
import CoreData
class PokemonTableDelegate:NSObject,UITableViewDelegate,UITableViewDataSource{
   
    weak var table: UITableView!
    static let sharedInstance = PokemonTableDelegate()
    var arrayOfPokemons: Array<PokemonCD>!
    private override init(){
        super.init()
        arrayOfPokemons = CoreDataPokemonManager.sharedInstance.getObjects("PokemonCD") as! [PokemonCD]
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonCell
        
        cell.setData(entity: arrayOfPokemons[indexPath.row])
        return cell
    }
    
    func createNewEntity(annotation: ImageAnnotation){
        let entity = NSEntityDescription.entity(forEntityName: "PokemonCD", in: CoreDataPokemonManager.sharedInstance.managedObjectContext)
        let record = PokemonCD(entity: entity!, insertInto: CoreDataPokemonManager.sharedInstance.managedObjectContext)
        record.power = String("\(annotation.power)")
        record.title = annotation.title
        record.image = UIImagePNGRepresentation(annotation.image!) as NSData?
        arrayOfPokemons.append(record)
        table.reloadData()
    }
}
