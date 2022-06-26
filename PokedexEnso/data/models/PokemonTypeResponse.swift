//
//  PokemonTypeResponse.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import Foundation
class PokemonTypeResponse:Codable{
    var names:[NameTypes]
    var name:String
    enum CodingKeys: String, CodingKey {
        case names
        case name
    }
}


class NameTypes:Codable{
    var name:String
    var language:Lenguage
    enum CodingKeys: String, CodingKey {
        case name
        case language
       
    
    }
}

class Lenguage:Codable{
    var name:String
    enum CodingKeys: String, CodingKey {
        case name
       
    
    }
}
