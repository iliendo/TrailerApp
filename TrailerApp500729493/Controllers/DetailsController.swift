//
//  DetailsController.swift
//  TrailerApp500729493
//
//  Created by Ilias Azagagh on 5/5/19.
//  Copyright © 2019 Ilias Azagagh. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import AVKit
import AVFoundation

class DetailsController: UIViewController {

    @IBOutlet weak var bannerView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var labelTextView: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var buttonView: UIButton!

    let bullet = NSLocalizedString("bullet_dot", comment: "")
    var movie: Movie?
    var movieUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stillUrl = movie?.stillImage
        let posterUrl = movie?.posterImage
        
        // Make navigation bar transparent and color return control white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .white
        
        labelTextView.text = movie?.title
        buttonView.setTitle(NSLocalizedString("Watch trailer", comment: ""), for: .normal)
        descriptionTextView.text = movie?.description
        
        if let url = movie?.url {
            movieUrl = URL(string: url)!
        }
        
        
        // Get banner
        if let url = stillUrl {
            bannerView.kf.setImage(with: URL(string: url), options: [.transition(.fade(0.3))])
        }
        
        // Get poster
        if let url = posterUrl {
            posterView.kf.setImage(with: URL(string: url), options: [.transition(.fade(0.3))])
        }
        
    }
    
    @IBAction func playTrailer(_ sender: UIButton) {
        startMoviePlayer(url: movieUrl!)
    }
    
    /*
     * Spin up AVPlayer for given URL
     */
    func startMoviePlayer(url: URL) {
        
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
}
