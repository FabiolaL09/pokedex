//
//  PokemonRepository.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import Foundation
import Combine
import SwiftUI
protocol PokemonRepository {
    var apiSession: APIService {get}
    
}

extension PokemonRepository {
    func callMethod<T,D:Decodable>(body: T,request:URLRequest) -> AnyPublisher<D, APIError> {
        return apiSession.request(with: request)
            .eraseToAnyPublisher()
    }
    
    func getPokemonListService (offset:Int) -> AnyPublisher <PokemonListResponse, APIError>{
        return callMethod(body: [:], request: ApiRequest().getPokemonList(offset: offset))
    }
    
    func getPokemonDetailService (url:String) -> AnyPublisher <PokemonDetailResponse, APIError>{
        return callMethod(body: [:], request: ApiRequest().getPokemonDetail(url: url))
    }
    
    func getPokemonTypeService (url:String) -> AnyPublisher <PokemonTypeResponse, APIError>{
        return callMethod(body: [:], request: ApiRequest().getPokemonDetail(url: url))
    }
}
