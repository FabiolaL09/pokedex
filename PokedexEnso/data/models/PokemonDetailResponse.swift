//
//  PokemonDetailResponse.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import Foundation
class PokemonDetailResponse:Codable{
    var id:Int
    var name:String
    var height:Int
    var weight:Int
    var sprites:Sprite
    var types:[TypesPokemon]
   
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case sprites
        case types
        
    
    }
   
}
struct Sprite: Codable {
    let frontDefault: String
    let backDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault
        case backDefault
    }
}

struct TypesPokemon: Codable {
    
    let slot: Int
    var type: NameType
    
    enum CodingKeys: String, CodingKey {
        case slot
        case type
    }
    
}

struct NameType:Codable {
    
    var name:String
    let url:String
    var color:String?
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    init(from decoder: Decoder) throws {
               
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        switch name{
        case "grass":
            color = "#7AC74C"
        case "fire":
            color = "#EE8130"
        case "water":
            color = "#6390F0"
        case "fighting":
            color = "#C22E28"
        case "normal":
            color = "#A8A77A"
        case "flying":
            color = "#A98FF3"
        case "poison":
            color = "#A33EA1"
        case "ground":
            color = "#E2BF65"
        case "rock":
            color = "#B6A136"
        case "bug":
            color = "#A6B91A"
        case "ghost":
            color = "735797"
        case "steel":
            color = "#B7B7CE"
        case "electric":
            color = "#F7D02C"
        case "psychic":
            color = "#F95587"
        case "shadow":
            color = "#252850"
        case "unknown":
            color = "#9B9B9B"
        case "fairy":
            color = "#D685AD"
        case "dark":
            color = "#705746"
        case "ice":
            color = "#96D9D6"
        case "dragon":
            color = "#6F35FC"
        default:
            color = "#ffffff"
        }
        
            }
    
}

