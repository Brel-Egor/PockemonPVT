//
//  PokemonCD+CoreDataProperties.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 08.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//
//

import Foundation
import CoreData


extension PokemonCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonCD> {
        return NSFetchRequest<PokemonCD>(entityName: "PokemonCD")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var power: String?
    @NSManaged public var title: String?

}
