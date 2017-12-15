//
//  JsonManager.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 21.11.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import Foundation

struct Constants{
    struct Heroku {
        static let baseAPIURL = "https://pockeman.herokuapp.com/" //"http://192.168.100.12:8080"//
        static let smallPictFolder = "smallPict/"
    }
    struct HerokuGet {
        static let pokemons = "/Pockemons"
    }
}

struct Creatures: Codable{
    let pocks : Array<Pockemon>
}

struct Pockemon: Codable {
    let id: Int
    let name: String
    let power: Int
    let x: Double
    let y: Double
    let smallPictUrl: String
    let modelID: String
}









