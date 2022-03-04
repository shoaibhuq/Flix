//
//  MoviesViewController.swift
//  Flix
//
//  Created by Shoaib Huq on 2/21/22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private var movies = [MovieModel](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let movieURL = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print(movieURL)
        MovieManager.shared.requestData(with: movieURL){ movies in
            self.movies = movies
        }
    }
    
    
}

//MARK: - TableView

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieTableViewCell
        else{
            return UITableViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        
        return cell
                
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Loading up details screen")
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row] //Fix this error before moving in
        
        let destinationVC = segue.destination as! MovieDetailedViewController
        DispatchQueue.main.async {
            destinationVC.configure(with: movie)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }
    
    
}
