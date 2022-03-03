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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        MovieManager.shared.requestData{ movies in
            self.movies = movies
        }
    }
    
}

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
    
    
}
