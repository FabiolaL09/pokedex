//
//  ViewController.swift
//  PokedexEnso
//
//  Created by Fabiola Llanes on 25/06/22.
//

import UIKit
import Kingfisher

class PokemonViewController: UIViewController {
    
//    IBOulets
    
    @IBOutlet weak var searchBarPokemon: UISearchBar!
    
    @IBOutlet weak var listPokemon: UITableView!
    var viewmodel = PokemonListViewModel()
    let spinner = SpinnerViewController()
    var lisPokemon:[PokemonDetailResponse] = []
    
    var pokemonSelecct: PokemonDetailResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getBatchedList()
        
        self.listPokemon.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "cellTable")
        self.listPokemon.delegate = self
        self.listPokemon.dataSource = self
    
    }
}

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lisPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTable = listPokemon.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! PokemonTableViewCell
        cellTable.idPokemon.text = "# \(lisPokemon[indexPath.row].id)"
        cellTable.namePokemon.text = lisPokemon[indexPath.row].name.capitalized
        cellTable.typePokemon1.text = "\(lisPokemon[indexPath.row].types[0].type.name)"
        if (lisPokemon[indexPath.row].types.count>1){
        cellTable.typePokemon2.text = "\(lisPokemon[indexPath.row].types[1].type.name)"
        }else{
            cellTable.typePokemon2.text = ""
        }
        cellTable.ListView.backgroundColor = hexStringToUIColor(hex: "\(lisPokemon[indexPath.row].types[0].type.color ?? "")")
        cellTable.ListView.layer.cornerRadius = 30
        
       
        
        
        let texturl = "\(lisPokemon[indexPath.row].sprites.frontDefault)"
        let encodedURL = texturl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string:encodedURL ?? "")!
        let processor = DownsamplingImageProcessor(size: cellTable.imagePokemon.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        cellTable.imagePokemon.kf.indicatorType = .activity
        cellTable.imagePokemon.kf.setImage(
            with: url,
           
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
       
        
        
        return cellTable
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonSelecct = lisPokemon[indexPath.row]
        
        performSegue(withIdentifier: "DetailPokemon", sender: self)
        
        //Deseleccionar
        listPokemon.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailPokemon"{
            let DetailPokemon = segue.destination as! DetailPokemonViewController
            DetailPokemon.pokemonDetailResponse = pokemonSelecct
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == lisPokemon.count {
           getBatchedList()
        }
    }
    
    func createSpinnerView() {
        

        // add the spinner view controller
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)

        
    }
    
    func stopSpinner(){
        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            self.spinner.willMove(toParent: nil)
            self.spinner.view.removeFromSuperview()
            self.spinner.removeFromParent()
        }
    }
    
    func getBatchedList(){
        self.createSpinnerView()
        viewmodel.getPokemonListService(offset: lisPokemon.count){ result, error, offset in

            if(result != nil){
                result?.results.enumerated().forEach({ (index1,item) in
                    
                    self.viewmodel.getPokemonDetailService(url: item.url) { result2, error2 in
                        if (result2 != nil){
                            result2?.types.enumerated().forEach({ (index2,type) in
                                self.viewmodel.getPokemonTypeService(url: type.type.url) { result3, error3 in
                                    if (result3 != nil){
                                        
                                        result2?.types[index2].type.name = result3?.names[5].name ?? ""
                                        if (self.lisPokemon.count == offset + 20 ){
                                            self.stopSpinner()
                                            self.listPokemon.reloadData()
                                        }
                                    }else{
                                        print("error",error3.debugDescription)
                                    }
                                }
                            })
                        self.lisPokemon.append(result2!)
                            self.lisPokemon = self.lisPokemon.sorted(by: {
                                $0.id<$1.id
                            })
                            
                        }else{
                            print("error",error2.debugDescription)
                        }
                    }
                })
                
                
            }
            
           
        }
    }
    
    
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style:.large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = .clear
        spinner.translatesAutoresizingMaskIntoConstraints = false
      
        spinner.hidesWhenStopped = true
        spinner.style = UIActivityIndicatorView.Style.large
        spinner.startAnimating()
        view.addSubview(spinner)
       
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
