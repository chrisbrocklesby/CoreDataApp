import UIKit
import CoreData

func simpleFetch(){
	// Check if Core Data is setup
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		do {
			// Request data from Core Data Entity
			let request = NSFetchRequest<MyEntity>(entityName: "MyEntity")
			// The Result
			let result = try coreData.fetch(request).first
			print(result?.objectID ?? "Default Value")
			print(result?.title ?? "Default Value")
		} catch {
			// Error Handling
			fatalError("Failed: \(error)")
		}
	}
}


func simpleFetchIndex(){
	// Check if Core Data is setup
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		do {
			// Request data from Core Data Entity
			let request = NSFetchRequest<MyEntity>(entityName: "MyEntity")
			//request.predicate = NSPredicate(format: "title == %@", "Title matching this")
			// The Results
			let results = try coreData.fetch(request)
			for result in results {
				print(result.objectID)
				print(result.title ?? "Default Value")
				print(result.post ?? "Default Value")
			}
		} catch {
			// Error Handling
			fatalError("Failed: \(error)")
		}
	}
}


func simpleInsert(){
	// Check if Core Data is setup
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		do {
			// Set Insert
			let insert = MyEntity(entity: MyEntity.entity(), insertInto: coreData)
			insert.title = "Swift is OK"
			insert.post = "Hello World it is working."
			// Save the Insert
			try coreData.save()
		} catch {
			// Error Handling
			fatalError("Failed: \(error)")
		}
	}
}


func simpleDelete(objectID: NSManagedObjectID){
	// Check if Core Data is setup
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		do {
			// Delete Object based on objectID (Provided by last fetch)
			let object = coreData.object(with: objectID)
			coreData.delete(object)
			
			// Save the Delete
			try coreData.save()
		} catch {
			// Error Handling
			fatalError("Failed: \(error)")
		}
	}
}


func simpleUpdate(objectID: NSManagedObjectID){
	// Check if Core Data is setup
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		do {
			// Request data from Core Data Entity
			let request = NSFetchRequest<MyEntity>(entityName: "MyEntity")
			request.predicate = NSPredicate(format: "objectID == %@", objectID)
			
			// The Result
			let result = try coreData.fetch(request).first
			
			// Set Update Values
			result?.title = "New Updated Title"
			result?.post = "Here is the new post content"
			
			// Save the Update
			try coreData.save()
		} catch {
			// Error Handling
			fatalError("Failed: \(error)")
		}
	}
}


