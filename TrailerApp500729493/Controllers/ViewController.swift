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
        
        // Prepares the next screen
        tableView.delegate = self
        
        // Load the spinner until the data is retreived from the api
        let spinner = createSpinner()
        // Gets the json from the api
        Alamofire.request("https://appstubs.triple-it.nl/trailers/").responseData(completionHandler: {[weak self] (response) in guard let jsonData = response.data else {return}
            
            self?.removeSpinner(spinner: spinner)
            
            let jsonDecoder = JSONDecoder()
            // Decode an array of json data
            // try? => skip json try! => give error with no json
            let contentItem = try? jsonDecoder.decode([Movie].self, from: jsonData)
            
            self?.movieArray = contentItem!
        })
    }
    
    func createSpinner() -> SpinnerController {
        let child = SpinnerController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        return child
    }
    
    func removeSpinner(spinner: SpinnerController) {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
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

// Set Detail view delegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Define current storyboard
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Get a reference to the new controller
        let detailsController: DetailsController = storyboard.instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        
        // Pass current trailer on to detail view
        detailsController.movie = movieArray[indexPath.row]
        
        // Set push view
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}

