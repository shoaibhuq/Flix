//
//  MovieGridController.swift
//  Flix
//
//  Created by Shoaib Huq on 3/4/22.
//

import UIKit

class MovieGridController: UIViewController {
    
    private var movies = [MovieModel](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    let movieURL = "https://api.themoviedb.org/3/movie/634649/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        let height = width * 3 / 2
        
        layout.itemSize = CGSize(width: width, height: height)
        
        MovieManager.shared.requestData(with: movieURL){ movies in
            self.movies = movies
        }
    }
    
}

//MARK: - CollectionView

extension MovieGridController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? GridCellCollectionViewCell
        else{
            return UICollectionViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Loading up from collection to detailed screen")
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.row] //Fix this error before moving in
        
        let destinationVC = segue.destination as! GridDetailedViewContorllerViewController
        DispatchQueue.main.async {
            destinationVC.configure(with: movie)
            self.collectionView.deselectItem(at: indexPath, animated: true)
        }
        
    }
}
