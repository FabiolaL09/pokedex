//
//  ApiSession.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import Foundation
import Combine

struct APISession: APIService {
    func request<T>(with builder: URLRequest) -> AnyPublisher<T, APIError> where T: Decodable {
        
        // json decoder instance
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return URLSession.shared
            .dataTaskPublisher(for: builder)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    print("respuesta url:\(response.url!.absoluteString)")
                    print("respuesta código: \(response.statusCode)")
                    let body:String? = String(data: data, encoding: .utf8)
                    print("respuesta \(body!)")
                    
                    if (200...299).contains(response.statusCode) {

                        
                        if(response.statusCode == 204){ //no content
                            return Just("{}".data(using: .utf8)!)
                                .decode(type: T.self, decoder: decoder)
                                .mapError {_ in .decodingError}
                                .eraseToAnyPublisher()
                        }else{
                            return Just(data)
                                .decode(type: T.self, decoder: decoder)
                                .mapError {_ in .decodingError}
                                .eraseToAnyPublisher()
                        }
                       
                    } else {
                       
                            if (response.statusCode == 422){
                                do{ let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                                    
                                    return Fail(error: APIError.httpError(response.statusCode,json)).eraseToAnyPublisher()
                                }catch{ print("erroMsg") }
                            }else{
                       
                        return Fail(error: APIError.httpError(response.statusCode,nil)).eraseToAnyPublisher()
                            }
                    }
                }
                return Fail(error: APIError.unknown)
                        .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
