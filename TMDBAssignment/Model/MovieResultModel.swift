//
//  MovieResultModel.swift
//  AssignmentMovie
//
//  Created by Susanta Mukherjee on 27/11/2020.
//  Copyright © 2020 Susanta Mukherjee. All rights reserved.
//

import Foundation
import UIKit

struct MovieResultModel : Codable {

    public let id: Int?
    public let title: String?
    public let backdropPath: String?
    public let posterPath: String?
    public let overview: String?
    public let releaseDate: Date?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let adult: Bool?
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }
    
}

struct MovieResults : Codable {

    
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [MovieResultModel]
    
}
 

