//
//  Movie.swift
//  Flix
//
//  Created by Shoaib Huq on 2/21/22.
//

import Foundation


struct MovieData: Codable{
    let results: [Results]
}

struct Results: Codable{
    let title: String
    let overview: String
    let poster_path: String
    let backdrop_path: String
    let release_date: String
}
