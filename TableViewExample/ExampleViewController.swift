//
//  ViewController.swift
//  TableViewExample
//
//  Created by Christopher Hannah on 08/09/2018.
//  Copyright © 2018 Christopher Hannah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ExampleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var idDrinks = [String]()
    var name = [String]()
    var photo = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        fetchData()
        
    }
    
    
    func fetchData() {
        let apiurl = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?g=Cocktail_glass"
        
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
                    let idDrink = i["idDrink"].stringValue
                    self.idDrinks.append(idDrink)
                    let nameDrink = i["strDrink"].stringValue
                    self.name.append(nameDrink)
                    let photoDrink = i["strDrinkThumb"].stringValue
                    self.photo.append(photoDrink)
                }
                self.tableView.reloadData()
                
                break
            case .failure:
                let alert = UIAlertController(title: "Alert", message: "Error de conexión", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idDrinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        
        cell.titleLabel?.text = name[indexPath.row]
        let imageURL = NSURL(string: photo[indexPath.row])
        if imageURL != nil {
            let data = NSData(contentsOf: (imageURL as URL?)!)
            cell.fondoImage.image = UIImage(data: data! as Data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailDrinksViewController") as? DetailDrinksViewController
        vc?.id = idDrinks[indexPath.row]
        presentVC(vc!, animated: true)
    }
    
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    


}

