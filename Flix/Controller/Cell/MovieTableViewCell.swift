//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Shoaib Huq on 2/24/22.
//

import UIKit
import AlamofireImage

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with movie: MovieModel){
        movieTitle.text = movie.title
        movieDescription.text = movie.description
        let baseUrl = "https://image.tmdb.org/t/p/w185/\(movie.imageURL)"
        movieImage.af.setImage(withURL: URL(string: baseUrl)!)
        
    }

}
