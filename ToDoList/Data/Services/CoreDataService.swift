//
//  CoreDataService.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

protocol CoreDataService {
    func saveEntity(entityName: String, attributes: [String: Any])
    func fetchEntities(entityName: String) -> [NSManagedObject]
    func fetchEntityByParameter(entityName: String, parameterName: String, parameterValue: UUID) -> [NSManagedObject]?
    func updateItem<Value>(entityName: String, id: UUID, propertyName: String, newValue: Value)
    func updateItem(entityName: String, id: UUID, updatedProperties: [String: Any])
    func deleteEntityById(entityName: String, id: UUID)
}

class CoreDataServiceImpl: CoreDataService {
    private let coreDataStack = CoreDataStack.shared
    
    func saveEntity(entityName: String, attributes: [String: Any]) {
        let managedContext = coreDataStack.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        let newObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        attributes.forEach { key, value in
            newObject.setValue(value, forKey: key)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchEntities(entityName: String) -> [NSManagedObject] {
        let managedContext = coreDataStack.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            let entities = try managedContext.fetch(fetchRequest)
            return entities
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func fetchEntityByParameter(entityName: String, parameterName: String, parameterValue: UUID) -> [NSManagedObject]? {
        let managedContext = coreDataStack.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "\(parameterName) == %@", parameterValue as CVarArg)
        
        do {
            let objects = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            return objects
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func deleteEntityById(entityName: String, id: UUID) {
        let managedContext = coreDataStack.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let objects = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            for object in objects ?? [] {
                managedContext.delete(object)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch or delete. \(error), \(error.userInfo)")
        }
    }
    
    func updateItem<Value>(entityName: String, id: UUID, propertyName: String, newValue: Value) {
        let managedContext = coreDataStack.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let item = results?.first {
                item.setValue(newValue, forKey: propertyName)
                
                try managedContext.save()
            } else {
                print("Item not found")
            }
        } catch {
            print("Error updating item: \(error)")
        }
    }
    
    func updateItem(entityName: String, id: UUID, updatedProperties: [String: Any]) {
        let managedContext = coreDataStack.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let item = results?.first {
                // Iterate over the updatedProperties dictionary
                for (key, value) in updatedProperties {
                    if key != "id" { // Skip the 'id' field
                        item.setValue(value, forKey: key)
                    }
                }
                
                try managedContext.save()
            } else {
                print("Item not found")
            }
        } catch {
            print("Error updating item: \(error)")
        }
    }
}
