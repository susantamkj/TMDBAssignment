//
//  DetailsImageCell.swift
//  TMDBAssignment
//
//  Created by Susanta Mukherjee on 28/11/2020.
//  Copyright © 2020 Susanta Mukherjee. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsImageCell: UITableViewCell {

    @IBOutlet var aImageView: UIImageView!
    
    
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
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
