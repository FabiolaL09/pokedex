//
//  PokemonApi.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import Foundation
import Foundation
class ApiRequest{
    public static let URL_BASE = "https://pokeapi.co/api/v2"

    func genericGetMethod(url:String)->URLRequest{
        var urlRequest: URLRequest{
            let urlRequest:String="\(ApiRequest.URL_BASE)\(url)"
            guard let url = URL(string:urlRequest )
                else {
                if (URL(string:ApiRequest.URL_BASE) != nil ){
                    return URLRequest(url:URL(string: ApiRequest.URL_BASE)!)
                }
                preconditionFailure("Invalid URL format")}
            //print("branchesRequest: \(urlRequest)")
            
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            return request
        }
        return urlRequest
    }
    
    func genericGetMethodWithNoURL(url:String)->URLRequest{
        var urlRequest: URLRequest{
            let urlRequest:String="\(url)"
            guard let url = URL(string:urlRequest )
                else {
                if (URL(string:ApiRequest.URL_BASE) != nil ){
                    return URLRequest(url:URL(string: ApiRequest.URL_BASE)!)
                }
                preconditionFailure("Invalid URL format")}
            //print("branchesRequest: \(urlRequest)")
            
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            return request
        }
        return urlRequest
    }
    
   
    func getPokemonList (offset:Int) -> URLRequest{
        genericGetMethod(url: "/pokemon?limit=20&offset=\(offset)")
        
    }
    func getPokemonDetail (url:String) -> URLRequest{
        genericGetMethodWithNoURL(url: url)
        
    }
    
    func getPokemonType (url:String) -> URLRequest{
        genericGetMethodWithNoURL(url: url)
        
    }
    
}
