//
//  StorageManager.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import Foundation
import CoreData

class StorageManager {
    
    static var shared = StorageManager()
    
    // MARK: - Core Data stack
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ImageCollectionApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {}
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData(completion: (Result<[SaveImage], Error>) -> Void) {
        let fetchReqest = SaveImage.fetchRequest()
        
        do {
            let images = try viewContext.fetch(fetchReqest)
            completion(.success(images))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func save(_ newImage: Image) {
//        guard let entityDescription = NSEntityDescription.entity(forEntityName: "SaveImage", in: viewContext) else { return }
//        guard let image = NSManagedObject(entity: entityDescription, insertInto: viewContext) as? SaveImage else { return }
        let image = SaveImage(context: viewContext)
        image.image = newImage.urls.small
        image.authorName = newImage.user.name
        image.creationData = newImage.creationData
        image.location = newImage.links.downloadLocation
        image.loadingCount = Int64(newImage.likes ?? 0)
        saveContext()
    }
    
    func delete(_ image: SaveImage) {
        viewContext.delete(image)
        saveContext()
    }
}
