//
//  MovieViewCell.swift
//  TMDBAssignment
//
//  Created by Susanta Mukherjee on 27/11/2020.
//  Copyright © 2020 Susanta Mukherjee. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


class MovieViewCell: UITableViewCell {
    
    @IBOutlet var aImageView: UIImageView!
    @IBOutlet var aLabel: UILabel!
    
    var myMovie: MovieResultModel?{
        
        didSet{
            cellConfig()
        }
    }
    
    func cellConfig(){
        
        aImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        aImageView.sd_setImage(with: myMovie?.posterURL) { (image, error, cache, urls) in
            if (error != nil) {
                // Failed to load image
            } else {
                // Successful in loading image
                self.aImageView.image = image
            }
        }
        
        aLabel.text = myMovie?.title
    }
}
