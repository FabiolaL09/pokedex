//
//  BaseViewModel.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import Foundation
import Combine
import SwiftUI
class BaseViewModel: ObservableObject, PokemonRepository {
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    @Published var showLoader: Bool = false
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
    }
    
    func safeApiCall<D:Decodable>( apiCall:AnyPublisher<D, APIError>,handle: @escaping(_ result: D?, _ error: Error?) -> Void){
        showLoader = true
        let cancellable = apiCall
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                   // print("Handle error \(error)")
                    handle(nil, error)
                    
                    self.showLoader = false
                case .finished:
                   // print("Response \(result)")
                    self.showLoader = false
                    break
                }
            }, receiveValue: { (result) in
                handle(result, nil)
                
            })
        
        cancellables.insert(cancellable)
    }
}
