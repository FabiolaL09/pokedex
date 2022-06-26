//
//  PokemonListResponse.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import Foundation
class PokemonListResponse : Codable {
    var count : Int
    var next : String?
    var previous : String?
    var results: [PokemonListResponseItem]

    
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
        
    
    }
    
}

class PokemonListResponseItem:Codable{
    var name : String
    var url : String
    enum CodingKeys: String, CodingKey {
        case name
        case url
        
    
    }
}
