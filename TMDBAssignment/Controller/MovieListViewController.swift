//
//  MovieListViewController.swift
//  TMDBAssignment
//
//  Created by Susanta Mukherjee on 27/11/2020.
//  Copyright © 2020 Susanta Mukherjee. All rights reserved.
//

import UIKit


class MovieListViewController: BaseViewController {
  

    @IBOutlet var aTableView: UITableView!
    
    var movieResult = [MovieResultModel]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ConnectionManager.shareInstance.getMovieList(endpoint: REQUEST_TOPRATE) { [weak self] (movieResult, error) in
            
            if (error != nil){
                
                self?.showAlertWithMessages(withTitle: APP_NAME, withMessage: error!.localizedDescription)
            }
            else{
                guard let result = movieResult else{ return }
                print("resulr.....",movieResult!)
                
                self?.movieResult = result.results
                
                DispatchQueue.main.async {
                
                    self?.aTableView.reloadData()
                }
            }
            
        }
    }
    

    @IBAction func popular(_ sender: UIButton) {
        
        ConnectionManager.shareInstance.getMovieList(endpoint: REQUEST_POPULAR) {[weak self] (movieResult, error) in
            
            if(error != nil){
                
                self?.showAlertWithMessages(withTitle: APP_NAME, withMessage: error!.localizedDescription)
            }
            else{
                guard let result = movieResult else{ return }
                print("resulr.....",movieResult!)
                self?.movieResult = result.results
                  
                DispatchQueue.main.async {
                
                    self?.aTableView.reloadData()
                  }
            }
        }
    }
    
    @IBAction func rate(_ sender: UIButton) {
        
        ConnectionManager.shareInstance.getMovieList(endpoint: REQUEST_TOPRATE) { [weak self]  (movieResult, error) in
            
            if(error != nil){
                
               self?.showAlertWithMessages(withTitle: APP_NAME, withMessage: error!.localizedDescription)
            }
            else{
                
                guard let result = movieResult else{ return }
                print("resulr.....",movieResult!)
                self?.movieResult = result.results
                
                DispatchQueue.main.async {
                  
                    self?.aTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func searcBy(_ sender: UIButton){
        
        showAlertWithTextField()
    }
    
}















