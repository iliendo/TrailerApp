//
//  SpinnerController.swift
//  TrailerApp500729493
//
//  Created by Ilias Azagagh on 5/5/19.
//  Copyright © 2019 Ilias Azagagh. All rights reserved.
//

import Foundation
import UIKit

class SpinnerController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}
