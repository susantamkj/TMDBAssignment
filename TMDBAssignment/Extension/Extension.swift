//
//  ExtexsationFile.swift
//  TMDBAssignment
//
//  Created by Susanta Mukherjee on 29/11/2020.
//  Copyright © 2020 Susanta Mukherjee. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

//MARK: MovieListViewController extension

extension MovieListViewController : UITableViewDataSource,UITableViewDelegate{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell: MovieViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MovieViewCell
        cell.myMovie = self.movieResult[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 355
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let myMovie: MovieResultModel = self.movieResult[indexPath.row]
        
        let detailsView : MovieDetailsViewController = self.storyboard?.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
        detailsView.movieID = myMovie.id
        self.navigationController?.pushViewController(detailsView, animated: true)
        
    }
    
    func showAlertWithTextField() {
        
        let alertController = UIAlertController(title: APP_NAME, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Search", style: .default) { (_) in
            
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                // operations
                ConnectionManager.shareInstance.searchMovie(query: text) { [weak self](movieResult,error) in
                    
                    if(error != nil){
                        
                       self?.showAlertWithMessages(withTitle: APP_NAME, withMessage: error!.localizedDescription)
                    }else{
                        guard let result = movieResult else{ return }
                        self?.movieResult = result.results
                        
                        DispatchQueue.main.async {
                          
                            self?.aTableView.reloadData()
                        }
                    }
                   
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Please enter a string"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: MovieDetailsViewController extension

extension MovieDetailsViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myMovie: MovieResultModel = self.movieArr.first!
        
        if(indexPath.row == 0){
            
            let cell: DetailsImageCell = tableView.dequeueReusableCell(withIdentifier: "DetailsImageCell") as! DetailsImageCell
            
            cell.myMovie = myMovie

            return cell
        }
        else{
            
            let cell: DetailsCell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
            
            cell.myMovie = myMovie
            return cell
        }
                
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        if (indexPath.row == 0){
            
            return 405
        }
        else{
            
            return 294
        }
        
    }
    
}

