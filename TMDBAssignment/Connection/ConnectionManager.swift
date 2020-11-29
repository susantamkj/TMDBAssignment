//
//  ConnectionManager.swift
//  AssignmentMovie
//
//  Created by Susanta Mukherjee on 26/11/2020.
//  Copyright © 2020 Susanta Mukherjee. All rights reserved.
//

import Foundation

class ConnectionManager {
    
    static let shareInstance = ConnectionManager()
    private init(){}
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    //MARK: get movie list
    func getMovieList(endpoint endPoint:String,  completionSuccess: @escaping(MovieResults?, Error?) -> ()){

        guard let urlString = URL(string: "\(BASE_URL)/movie/\(endPoint)?api_key=\(API_KEY)&page=1")else{ return }

        URLSession.shared.dataTask(with: urlString) { (data, response, error) in

            if let err = error{

                completionSuccess(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }
            else{

                guard let data = data else{ return }

                do{

                    let moviesResponse = try self.jsonDecoder.decode(MovieResults.self, from: data)
                    CoreDataManager._shared.prepare(dataForSaving: moviesResponse.results)
                    completionSuccess(moviesResponse,nil)
                }
                catch let jsonErr{

                    print("json error : \(jsonErr.localizedDescription)")
                    completionSuccess(nil,jsonErr)
                }
            }


        }.resume()

    }
    
    
    
    //MARK: get movie details
    func getMovieWithID(movieID:Int,  completionSuccess: @escaping(MovieResultModel?, Error?) -> ()) ->(){
           
    guard let urlString = URL(string: "\(BASE_URL)/movie/\(movieID)?api_key=\(API_KEY)&append_to_response=videos,credits") else { return }
        
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            
            if let err = error{

                completionSuccess(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }
            else{

                guard let data = data else{ return }

                do{

                    let moviesResponse = try self.jsonDecoder.decode(MovieResultModel.self, from: data)
                    completionSuccess(moviesResponse,nil)
                }
                catch let jsonErr{

                    print("json error : \(jsonErr.localizedDescription)")
                    completionSuccess(nil,jsonErr)
                }
            }
            
        }.resume()
        
   }
    
    
    func searchMovie(query: String, completionSuccess: @escaping (MovieResults?, Error?) -> Void) {
        
        //guard let urlString = URL(string: "\(BASE_URL)/search/movie/?api_key=\(API_KEY)&query=\(query)")else{ return }
        
        guard var urlComponents = URLComponents(string: "\(BASE_URL)/search/movie") else {

            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: API_KEY),
        URLQueryItem(name: "language", value: "en-US"),
        URLQueryItem(name: "include_adult", value: "false"),
        URLQueryItem(name: "region", value: "US"),
        URLQueryItem(name: "query", value: query)
        ]
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error{

                completionSuccess(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }
            else{

                guard let data = data else{ return }

                do{

                    let moviesResponse = try self.jsonDecoder.decode(MovieResults.self, from: data)
                    completionSuccess(moviesResponse,nil)
                }
                catch let jsonErr{

                    print("json error : \(jsonErr.localizedDescription)")
                    completionSuccess(nil,jsonErr)
                }
            }
            
        }.resume()
        
    }
    
    
  
}
