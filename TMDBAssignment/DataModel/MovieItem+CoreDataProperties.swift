//
//  MovieItem+CoreDataProperties.swift
//  TMDBAssignment
//
//  Created by Susanta Mukherjee on 29/11/2020.
//  Copyright © 2020 Susanta Mukherjee. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieItem> {
        return NSFetchRequest<MovieItem>(entityName: "MovieItem")
    }

    @NSManaged public var id: NSObject?
    @NSManaged public var title: NSObject?
    @NSManaged public var backdropPath: NSObject?
    @NSManaged public var posterPath: NSObject?
    @NSManaged public var overview: NSObject?
    @NSManaged public var releaseDate: NSObject?
    @NSManaged public var voteAverage: NSObject?
    @NSManaged public var voteCount: NSObject?
    @NSManaged public var tagline: NSObject?
    @NSManaged public var adult: NSObject?
    @NSManaged public var runtime: NSObject?
    @NSManaged public var posterURL: NSObject?
    @NSManaged public var backdropURL: NSObject?

}
