//
//  TableViewCell.swift
//  TableViewExample
//
//  Created by Baxten on 8/16/19.
//  Copyright © 2019 Christopher Hannah. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate:class {
    func clickDelete(index:IndexPath)
    func clickEdit(index:IndexPath)
}

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var fondoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fondoImage.layer.cornerRadius = 15
        // Initialization code
    }
    
    
    private weak var delegate:ExampleViewController!
    private var indexPath:IndexPath!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
