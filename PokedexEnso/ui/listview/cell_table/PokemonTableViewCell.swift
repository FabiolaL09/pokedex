//
//  PokemonTableViewCell.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ListView: UIView!
    @IBOutlet weak var typePokemon2: UILabel!
    @IBOutlet weak var typePokemon1: UILabel!
    @IBOutlet weak var idPokemon: UILabel!
    @IBOutlet weak var namePokemon: UILabel!
    
    @IBOutlet weak var imagePokemon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))
        
    }
    
}


