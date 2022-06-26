//
//  PokemonListViewModel.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import Foundation
class PokemonListViewModel : BaseViewModel {

   
    func getPokemonListService(offset:Int, handle: @escaping(_ result: PokemonListResponse?, _ error: Error?, _ offset:Int) -> Void){
       
        safeApiCall(apiCall: self.getPokemonListService(offset: offset)){ result, error in
            handle(result,error,offset)

        }
    }
    
    func getPokemonDetailService(url:String, handle: @escaping(_ result: PokemonDetailResponse?, _ error: Error?) -> Void){
       
        safeApiCall(apiCall: self.getPokemonDetailService(url: url)){ result, error in
            handle(result,error)
            
        }
    }
    
    func getPokemonTypeService(url:String, handle: @escaping(_ result: PokemonTypeResponse?, _ error: Error?) -> Void){
       
        safeApiCall(apiCall: self.getPokemonTypeService(url: url)){ result, error in
            handle(result,error)
            
        }
    }
}
