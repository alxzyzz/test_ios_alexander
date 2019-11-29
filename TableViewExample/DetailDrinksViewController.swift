//
//  DetailDrinks.swift
//  TableViewExample
//
//  Created by Baxten on 28/11/19.
//  Copyright © 2019 Christopher Hannah. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class DetailDrinksViewController : UIViewController {
    
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var ingredientsDetailLabel: UILabel!
    @IBOutlet weak var instructionsDetailLabel: UILabel!
    
    
    
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var viewMain: UIView!
    var id = ""
    var idDrinks = [String]()
    var name = ""
    var photo = [String]()
    var instructions = [String]()
    var ingredients = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //nameDetailLabel.text = name
        let idDrink = id
        viewMain.layer.cornerRadius = 10
        imageDetail.layer.cornerRadius = 10
        viewImage.layer.cornerRadius = 10
        fetchData(id: idDrink)
        //downloadData()
        //nameDetailLabel.text = idDrinks
       
       
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func fetchData(id: String) {
        let apiurl = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)"
        
        self.showSpinner(onView: self.view)
        Alamofire.request(apiurl, method: .get).responseJSON{(myresponse) in
            switch myresponse.result {
            case .success:
                self.removeSpinner()
                print(myresponse.result)
                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult!["drinks"]
                for i in resultArray.arrayValue {
                    
                    print(i)
                    
                    let idDrink = i["strDrink"].stringValue
                    self.idDrinks.append(idDrink)
                    let image = i["strDrinkThumb"].stringValue
                    self.photo.append(image)
                    let ingredient = i["strIngredient1"].stringValue
                    self.ingredients.append(ingredient)
                    let instruction = i["strInstructions"].stringValue
                    self.instructions.append(instruction)
                    
                    
                    self.nameDetailLabel.text = idDrink
                    self.instructionsDetailLabel.text = instruction
                    self.ingredientsDetailLabel.text = ingredient
                    
                    let imageURL = NSURL(string: image)
                    if imageURL != nil {
                        let data = NSData(contentsOf: (imageURL as URL?)!)
                        self.imageDetail.image = UIImage(data: data! as Data)
                    }
                }
                
                
                break
            case .failure:
                break
            }
        }
    }
    
    
}
    
    
    
    

