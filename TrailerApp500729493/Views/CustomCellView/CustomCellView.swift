//
//  CustomCellView.swift
//  TrailerApp500729493
//
//  Created by Ilias Azagagh on 4/12/19.
//  Copyright © 2019 Ilias Azagagh. All rights reserved.
//

import UIKit

final class CustomCellView: UITableViewCell {
    
    @IBOutlet weak var imageViewContainer: UIImageView!
    
    @IBOutlet weak var labelContainer: UILabel!
    
    @IBOutlet weak var descriptionContainer: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        labelContainer.text = nil
        descriptionContainer.text = nil
        
    }
    
}

