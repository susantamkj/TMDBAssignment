//
//  MovieDetailsViewController.swift
//  TMDBAssignment
//
//  Created by Susanta Mukherjee on 28/11/2020.
//  Copyright © 2020 Susanta Mukherjee. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: BaseViewController {
    
    var movieID : Int!
    @IBOutlet var aTableView: UITableView!
    var movieArr = [MovieResultModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConnectionManager.shareInstance.getMovieWithID(movieID: movieID) { [weak self] (result, error) in
            
            guard let movieResult = result else{ return }
            
            if(error != nil){
                self?.showAlertWithMessages(withTitle: APP_NAME, withMessage: error!.localizedDescription)
            }
            else{
                
                self?.movieArr.append(movieResult)
                DispatchQueue.main.sync {
                    
                    self?.aTableView.dataSource = self
                    self?.aTableView.delegate = self
                    self?.aTableView.reloadData()
                }
            }
            
            
        }
    }
    
}


