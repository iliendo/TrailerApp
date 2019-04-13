//
//  ViewController.swift
//  TrailerApp500729493
//
//  Created by Ilias Azagagh on 4/12/19.
//  Copyright © 2019 Ilias Azagagh. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var movieArray: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connects the tableview with the controller
        tableView.dataSource = self
        // Connect the custom cell to the tableview
        tableView.register(UINib(nibName: "CustomCellView", bundle: nil), forCellReuseIdentifier: "CustomCellView")
        
        // Big titles to the screen
        title = "Trailers"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Gets the json from the api
        Alamofire.request("https://appstubs.triple-it.nl/trailers/").responseData(completionHandler: {[weak self] (response) in guard let jsonData = response.data else {return}
            
            let jsonDecoder = JSONDecoder()
            // Decode an array of json data
            // try? => skip json try! => give error with no json
            let contentItem = try? jsonDecoder.decode([Movie].self, from: jsonData)
            
            self?.movieArray = contentItem!
        })
    }
}


extension ViewController:UITableViewDataSource{
    // Then number of cells needed for the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    // Set the content of the cel
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Recycle the custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellView", for: indexPath) as! CustomCellView
        
        // Set the label to the attributes in the array
        let url = URL(string: movieArray[indexPath.row].posterImage)
        cell.imageViewContainer.kf.setImage(with: url)
        cell.labelContainer.text = movieArray[indexPath.row].title
        cell.descriptionContainer.text = movieArray[indexPath.row].description
        
        return cell
    }
}

