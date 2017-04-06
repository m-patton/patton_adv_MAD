//
//  ViewController.swift
//  pokemon
//
//  Created by Mae Patton on 4/4/17.
//  Copyright © 2017 atlas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var nameArr = [String]()
    var candyArr = [String]()
    var imgURLArr = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let urlPath = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadJson()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //helpful tutorial: https://www.youtube.com/watch?v=ea6_a_zbQrY
    func loadJson() {
        let url = NSURL(string: urlPath)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data,response,error)-> Void in
            if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let pokeArray = json!.value(forKey: "pokemon") as? NSArray {
                    for pokes in pokeArray {
                        if let pokeDict = pokes as? NSDictionary {
                            if let name = pokeDict.value(forKey: "name"){
                                self.nameArr.append(name as! String)
                            }
                            if let type = pokeDict.value(forKey: "candy"){
                                self.candyArr.append(type as! String)
                            }
                            if let image = pokeDict.value(forKey: "img"){
                                self.imgURLArr.append(image as! String)
                            }
                            
                            OperationQueue.main.addOperation ({
                                self.tableView.reloadData()
                            })
                        }
                    }
                }
            }
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.nameLabel.text = nameArr[indexPath.row]
        cell.typeLabel.text = candyArr[indexPath.row]
        
        let imgURL = NSURL(string:imgURLArr[indexPath.row])
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.pokeImage.image = UIImage(data: data as! Data)
        }
        
        return cell
        
    }
    
}

