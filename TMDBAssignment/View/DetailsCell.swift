//
//  DetailsCell.swift
//  TMDBAssignment
//
//  Created by Susanta Mukherjee on 28/11/2020.
//  Copyright © 2020 Susanta Mukherjee. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var releasedateLbl: UILabel!
    @IBOutlet var votecountLbl: UILabel!
    @IBOutlet var overviewLbl: UILabel!
    
    
    
    var myMovie: MovieResultModel?{
        
        didSet{
            cellConfig()
        }
    }
    
    func cellConfig(){
        
        titleLbl.text = myMovie?.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y"
        
        releasedateLbl.text = formatter.string(from: (myMovie?.releaseDate!)!)
        
        if let voteCount = myMovie?.voteCount {
           votecountLbl.text = String(voteCount )
        }
        else{
           votecountLbl.text = "";
        }
        overviewLbl.text = myMovie?.overview
    }
    
}
