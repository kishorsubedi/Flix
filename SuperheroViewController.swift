//
//  SuperheroViewController.swift
//  flix
//
//  Created by Sudarshan Prajapati on 2/11/18.
//  Copyright © 2018 Sudarshan Prajapati. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController,UICollectionViewDataSource {
    
    var movies: [[String:Any]] = []

    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        fetchmovies()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        if let posterpathString = movie["poster_path"] as? String
        {
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURLString + posterpathString)!
            cell.posterImageView.af_setImage(withURL: posterURL)
            
        }
        return cell
    }
    
    func fetchmovies()
    {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval : 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            //sdasdasd
            
            if let error = error{
                print(error.localizedDescription)
            }
            else if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                
                //self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
                //self.refreshcontrol.endRefreshing()
            }
        }
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
