//
//  CollectionViewCell.swift
//  TestCollectionViewInTableviewCell
//
//  Created by Franklin Samboní on 18/12/19.
//  Copyright © 2019 Franklin Samboní. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var titleC: UILabel!
    @IBOutlet weak var textC: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(card: Card){
        titleC.text = card.title
        textC.text = card.text
    }
}
