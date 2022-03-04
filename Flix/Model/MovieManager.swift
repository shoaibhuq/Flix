//
//  MovieManager.swift
//  Flix
//
//  Created by Shoaib Huq on 2/21/22.
//

import Foundation


struct MovieManager{
    static let shared = MovieManager()
    
    func requestData(with movieURL: String, completion: @escaping(([MovieModel]) -> Void)){
        
        var movies = [MovieModel]()
        
        print(movieURL)
        if let url = URL(string: movieURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("There is an error")
                    return
                }
                if let safeData = data {
                    print("data is valid")
                    movies = parseJSON(safeData)!
                }
                completion(movies)
            }
            task.resume()
        }
    }
    
    func parseJSON(_ movieData: Data) -> [MovieModel]?{
        
        var movies = [MovieModel]()
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            
            for obj in decodedData.results{
                let movieTitle = obj.title
                let movieDesc = obj.overview
                let imageUrl = obj.poster_path
                let backDropUrl = obj.backdrop_path
                let releaseDate = obj.release_date
                
                
                let movie = MovieModel(title: movieTitle, description: movieDesc, imageURL: imageUrl, backdropURL: backDropUrl, releaseDate: releaseDate)
                
                movies.append(movie)
                
            }
            
            return movies
            
        } catch {
            print(error)
            return nil
        }
    }
    
    
    
    /*
    func requestData(completion: @escaping (([MovieData]) -> Void)){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else{
                print("error")
                return
            }
            guard let safeData = data else {
                print("got no data")
                return
            }
            let dataDictionary = try! JSONSerialization.jsonObject(with: safeData, options: []) as! [String:Any]
            let movieRawData = dataDictionary["results"] as! [[String:Any]]
            
            var movies = [MovieData]()
            
            for rawData in movieRawData{
                
            }
            
        }
        task.resume()
        
    }
     */
        
    
}

