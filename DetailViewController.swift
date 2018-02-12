//
//  DetailViewController.swift
//  flix
//
//  Created by Sudarshan Prajapati on 2/11/18.
//  Copyright © 2018 Sudarshan Prajapati. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: [String: Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie
        {
            titleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURLString+backdropPathString)!
            backDropImageView.af_setImage(withURL: backdropURL)
            
            let posterpathURL = URL(string: baseURLString+posterPathString)!
            posterImageView.af_setImage(withURL: posterpathURL)
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
