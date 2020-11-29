//
//  CoreDataManager.swift
//  AssignmentMovie
//
//  Created by Susanta Mukherjee on 26/11/2020.
//  Copyright © 2020 Susanta Mukherjee. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    
    private override init() {
        super.init()
        applicationLibraryDirectory()
    }
    // Create a shared Instance
    static let _shared = CoreDataManager()
    
    // Shared Function
    class func shared() -> CoreDataManager{
        return _shared
    }
    
    // Get the location where the core data DB is stored
    
    private lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1])
        return urls[urls.count-1]
    }()
    
    private func applicationLibraryDirectory() {
        print(applicationDocumentsDirectory)
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
    
    
    // MARK: - Core Data stack
    
    // Get the managed Object Context
    
    lazy var managedObjectContext = {
        
        return self.persistentContainer.viewContext
    }()
    
    // Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TMDBAssignment")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func prepare(dataForSaving: [MovieResultModel]){
        
        // loop through all the data received from the Web and then convert to managed object and save them
        _ = dataForSaving.map{self.createEntityFrom(myMovie: $0)}
        saveData()
    }
    
    private func createEntityFrom(myMovie: MovieResultModel) -> MovieItem?{
        
        // Check for all values

        let posterURL = myMovie.posterURL
        let backdropURL = myMovie.backdropURL
        let id = myMovie.id
        let title = myMovie.title
        let backdropPath = myMovie.backdropPath
        let posterPath = myMovie.posterPath
        let overview = myMovie.overview
        let releaseDate = myMovie.releaseDate
        let voteAverage = myMovie.voteAverage
        let voteCount = myMovie.voteCount
        let adult = myMovie.adult

        // Convert
        let albumItem = MovieItem(context: self.managedObjectContext)
        
        albumItem.id = id! as NSObject
        albumItem.title = title! as NSObject
        albumItem.backdropPath = backdropPath! as NSObject
        albumItem.posterPath = posterPath! as NSObject
        albumItem.overview = overview! as NSObject
        albumItem.releaseDate = releaseDate! as NSObject
        albumItem.voteAverage = voteAverage! as NSObject
        albumItem.voteCount = voteCount! as NSObject
        albumItem.adult = adult! as NSObject
        albumItem.posterURL = posterURL as NSObject
        albumItem.backdropURL = backdropURL as NSObject
       
        return albumItem
        
        
    }
    
    // Save the data in Database
       func saveData(){
           
           let context = self.managedObjectContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   // Replace this implementation with code to handle the error appropriately.
                   // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }
    
    
    // Save Data in background
       func saveDataInBackground() {
           
           persistentContainer.performBackgroundTask { (context) in
               
               if context.hasChanges {
                   do {
                       try context.save()
                   } catch {
                       // Replace this implementation with code to handle the error appropriately.
                       // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                       let nserror = error as NSError
                       fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                   }
               }
           }
       }
    
    
}
