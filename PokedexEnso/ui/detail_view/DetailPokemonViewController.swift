//
//  DetailPokemonViewController.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import UIKit
import SwiftUI
import Kingfisher

class DetailPokemonViewController: UIViewController {
    
    var pokemonDetailResponse: PokemonDetailResponse?
    
    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var imageFront: UIImageView!
    @IBOutlet weak var imagePokeFront: UIImageView!
    
    @IBOutlet weak var imageExample: UIImageView!
    @IBOutlet weak var imaPokeBack: UIImageView!
    
    @IBOutlet var viewBackgroundColor: UIView!
    @IBOutlet weak var imageBackgroundColor: UIView!
    @IBOutlet weak var idPokemon: UILabel!
    @IBOutlet weak var namePokemon: UILabel!
    
    @IBOutlet weak var typePokemon1: UILabel!
    @IBOutlet weak var typePokemon2: UILabel!
    
    @IBOutlet weak var heightPokemon: UILabel!
    
    @IBOutlet weak var weightPokemon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//
        idPokemon.text = String("# \(pokemonDetailResponse?.id ?? 0)")
        
        typePokemon1.text = "\(pokemonDetailResponse?.types[0].type.name ?? "")"

        typePokemon1.backgroundColor = hexStringToUIColor(hex: "\(pokemonDetailResponse?.types[0].type.color ?? "")")
        typePokemon1.layer.cornerRadius = 20
        typePokemon1.layer.masksToBounds = true


        if (pokemonDetailResponse?.types.count ?? 0>1){
           typePokemon2.text = "\(pokemonDetailResponse?.types[1].type.name ?? "")"
            typePokemon2.backgroundColor = hexStringToUIColor(hex: "\(pokemonDetailResponse?.types[1].type.color ?? "")")
            typePokemon2.layer.cornerRadius = 20
            typePokemon2.layer.masksToBounds = true

        }else{
            typePokemon2.text = ""
        }
        namePokemon.text = pokemonDetailResponse?.name.capitalized
//
        
        let texturl = "\(pokemonDetailResponse?.sprites.backDefault ?? "")"
        let encodedURL = texturl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string:encodedURL ?? "")!
        let processor = DownsamplingImageProcessor(size: imageBack.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        imageBack.kf.indicatorType = .activity
        imageBack.kf.setImage(
            with: url,
            //placeholder: UIImage(named: "pokemon"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(2)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        let texturl2 = "\(pokemonDetailResponse?.sprites.frontDefault ?? "")"
        let encodedURL2 = texturl2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url2 = URL(string:encodedURL2 ?? "")!
        let processor2 = DownsamplingImageProcessor(size: imageFront.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        imageFront.kf.indicatorType = .activity
        imageFront.kf.setImage(
            with: url2,
            //placeholder: UIImage(named: "pokemon"),
            options: [
                .processor(processor2),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(2)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }

        heightPokemon.text = String("Altura: \(pokemonDetailResponse?.height ?? 0) cm" )
        weightPokemon.text = String("Peso: \(pokemonDetailResponse?.weight ?? 0) gr")

        imageBackgroundColor.backgroundColor = hexStringToUIColor(hex: "\(pokemonDetailResponse?.types[0].type.color ?? "")")
       imageBackgroundColor.layer.cornerRadius = 30
        
        viewBackgroundColor.backgroundColor = UIColor(named: "fondo")

       
        
        
        
    }
    
    
   

}


