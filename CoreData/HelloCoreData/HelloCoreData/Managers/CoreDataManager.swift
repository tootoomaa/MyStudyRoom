//
//  CoreDataManager.swift
//  HelloCoreData
//
//  Created by 김광수 on 2022/08/29.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "HelloCoreDataModel")
        self.persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed to initialization \(error.localizedDescription)")
            }
        }
    }
    
}

extension CoreDataManager {
    /// <#Description#>
    /// - Returns: <#description#>
    func getAllMovies() -> [Movie] {
        
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteModel(movie: Movie) {
        
        persistentContainer.viewContext.delete(movie)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Fail to delete movie \(error.localizedDescription)")
        }
        
    }
    
    /// Movie 데이터 저장
    /// - Parameter title: Movie Title
    func saveMovie(title: String) {
        
        let movie = Movie(context: persistentContainer.viewContext)
        movie.title = title
        
        do {
            try persistentContainer.viewContext.save()
            print("Movie saved")
        } catch {
            print("Fail to save movie \(error.localizedDescription)")
        }
        
    }
    
    func updateMovie() {
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
        
    }
}

extension CoreDataManager {
    func fetchAllMovieActor() -> [MovieActor] {
        let fetchRequest: NSFetchRequest<MovieActor> = MovieActor.fetchRequest()
        
        do {
            let movieActor = try self.persistentContainer.viewContext.fetch(fetchRequest)
            return movieActor
        } catch {
            print("Fail to fetch Data \(error.localizedDescription)")
            return []
        }
    }
    
    func addMovieActor(name: String) {
        let actor = MovieActor(context: persistentContainer.viewContext)
        actor.name = name
        
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save Movie Actor")
        }
    }
    
    func deleteMovieActor(actor: MovieActor) {
        
        persistentContainer.viewContext.delete(actor)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Fail to delete movie \(error.localizedDescription)")
        }
        
    }
    
    func updateMovieActor() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
    }
}

extension CoreDataManager {
    func fetchAllCoreData<T: NSManagedObject>() -> [T] {
        
        let fetchReqeust: NSFetchRequest = T.fetchRequest()
        
        do {
            let data = try persistentContainer.viewContext.fetch(fetchReqeust)
            guard let changedData = data as? [T] else {
                return []
            }
            return changedData
        } catch {
            print("Fail to get \(T.self) list")
            return []
        }
    }
    
    func addCoreData<T: NSManagedObject>(data: T) {
        do {
            try self.saveData(inputData: data)
            try self.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save Movie Actor")
        }
    }
}

extension CoreDataManager {
    private func saveData<T: NSManagedObject>(inputData: T) throws {
        if let newInputData = inputData as? Movie {
            let myData = Movie(context: persistentContainer.viewContext)
            myData.title = newInputData.title
        } else {
            throw TestError.outOfRange
        }
        
        if let newInputData = inputData as? MovieActor {
            let myData = MovieActor(context: persistentContainer.viewContext)
            myData.name = newInputData.name
        } else {
            throw TestError.outOfRange
        }
    }
}

enum TestError : Error {
   case outOfRange                      // 1
   case invalidInput(testNum : Int)     // 2
}
