//
//  ApiService.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import Foundation
import Combine
protocol APIService {
    func request<T: Decodable>(with builder: URLRequest) -> AnyPublisher<T, APIError>
}
enum APIError: Error {
  
    case decodingError
    case httpError(Int?, [String : Any]?)
       
    case unknown
    
    func get() -> Int{
            switch self {
            case .httpError(let num,_):
                return num!
            default:
            return 10000
            }
    
        }
    func getBody()-> [String : Any]?{
        switch self {
        case .httpError(_,let json):
            return json!
        default:
            return [:]
        }
    }
}
