//
//  GridCellCollectionViewCell.swift
//  Flix
//
//  Created by Shoaib Huq on 3/4/22.
//

import UIKit
import AlamofireImage

class GridCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    func configure(with movie: MovieModel){
        
        let baseUrl = "https://image.tmdb.org/t/p/w500/\(movie.imageURL)"
        
        movieImageView.af.setImage(withURL: URL(string: baseUrl)!)
    }
    
}


