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
                    var array:[String] = []
                    var arrayMeasure:[String] = []
                    for n in 1...30{
                        let str  = i["strIngredient\(n)"].stringValue
                        let measure = i["strMeasure\(n)"].stringValue
                        if str != "null" && str.count > 0 {
                            array.append(str)
                           
                            
                        }
                        if measure != "null" && measure.count > 0 {
                            arrayMeasure.append(measure)
                            
                        }
                    }
                    
                    let instruction = i["strInstructions"].stringValue
                    self.instructions.append(instruction)
                    let tamaño = array.count
                    var ingredients = ""
                    for index in 0..<tamaño {
                        if arrayMeasure.count != array.count{
                            let alert = UIAlertController(title: "Alerta", message: "Error en los tamaños de los arreglos", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                            //self.present(alert, animated: true, completion: nil)
                            self.dismiss(animated: true, completion: nil)
                        }
                       
                        else{
                            let h = (arrayMeasure[index] + " - " + array[index] + "\n")
                            ingredients.append(h)
                            self.ingredientsDetailLabel.text = ingredients
                            
                        }
                        
                        
                    }
                    
                    self.nameDetailLabel.text = idDrink
                    self.instructionsDetailLabel.text = instruction
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
    
    
    
    

