//
//  ViewController.swift
//  flix
//
//  Created by Sudarshan Prajapati on 2/4/18.
//  Copyright © 2018 Sudarshan Prajapati. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource{

     @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
    var movies :[[String:Any]] = []
    var refreshcontrol: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector(ViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshcontrol, at: 0)
        tableView.dataSource = self
        
        activityIndicator.startAnimating()
        
        fetchmovies()
        
            }
    
    func didPullToRefresh(_ refreshcontrol: UIRefreshControl )
    {
        fetchmovies()
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
                
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                self.refreshcontrol.endRefreshing()
            }
        }
        task.resume()

    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return movies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            
            let movie = movies[indexPath.row]
            
            let title = movie["title"] as! String
            let overview = movie["overview"] as! String
            
            let posterPathString = movie["poster_path"] as! String
            
            let baseUrlString = "https://image.tmdb.org/t/p/w500"
            
            let posterURL = URL(string: baseUrlString + posterPathString)!
            
            cell.posterImageView.af_setImage(withURL: posterURL)
            
            cell.titleLabel.text = title
            cell.overviewLabel.text = overview
            
            return cell
            
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell)
        {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

