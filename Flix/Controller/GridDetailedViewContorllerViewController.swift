//
//  GridDetailedViewContorllerViewController.swift
//  Flix
//
//  Created by Shoaib Huq on 3/4/22.
//

import UIKit

class GridDetailedViewContorllerViewController: UIViewController {
    
    @IBOutlet weak var movieBackgroundPoster: UIImageView!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var mainMoviePoster: UIImageView!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configure(with movie: MovieModel){
        let mainImageUrl = "https://image.tmdb.org/t/p/w185/\(movie.imageURL)"
        let backgroundImageUrl = "https://image.tmdb.org/t/p/w780/\(movie.backdropURL)"
        
        
        movieTitle.text = movie.title
        movieTitle.sizeToFit()
        movieDescription.text = movie.description
        movieDescription.sizeToFit()
        movieReleaseDate.text = movie.releaseDate
        movieReleaseDate.sizeToFit()
        mainMoviePoster.af.setImage(withURL: URL(string: mainImageUrl)!)
        movieBackgroundPoster.af.setImage(withURL: URL(string: backgroundImageUrl)!)
        
    }
}
