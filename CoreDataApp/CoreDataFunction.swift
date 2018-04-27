import UIKit
import CoreData

///////////////////////// Core Data Variables /////////////////////////
var entityName = ""
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
let entitySet = NSEntityDescription.entity(forEntityName: entityName, in: context)
let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)


///////////////////////// Insert Core Data /////////////////////////
func insertCoreData(entity: String, key: String, value: String) {
	/// Set Entity of Data
	entityName = entity
	
	/// Insert Data
	let  insertData = NSManagedObject(entity: entitySet!, insertInto: context)
	insertData.setValue(value, forKey: key)
	print("Core Data: Inserted")
}


///////////////////////// Save Core Data /////////////////////////
func saveCoreData(entity: String) {
	/// Set Entity of Data
	entityName = entity
	
	/// Save Data
	do {
		try context.save()
		print("Core Data: Saved")
	} catch {
		print("Core Data: Save - \(error)")
		return
	}
}


///////////////////////// Index Core Data /////////////////////////
func indexCoreData(entity: String) {
	/// Set Entity of Data
	entityName = entity
	
	/// Request Settings
	request.returnsObjectsAsFaults = false // Performance Gain

	/// Get All Data for Index
	do {
		// Fetch
		let result = try context.fetch(request)
		// Loop
		for object in result as! [NSManagedObject] {
			print(object.value(forKey: "name") as! String)
			print(object.value(forKey: "country") as! String)
		}
		print("Core Data: Get Index Success")
	} catch {
		print("Core Data: Index - \(error)")
	}
}


///////////////////////// Get Core Data /////////////////////////
func getCoreData(entity: String, key: String, value: String) {
	/// Set Entity of Data
	entityName = entity
	
	/// Request Settings and Criteria
	request.predicate = NSPredicate(format: "\(key) = '\(value)'")
	request.returnsObjectsAsFaults = false // Performance Gain
	
	/// Get Data based on Request
	do {
		// Fetch
		let result = try context.fetch(request)
		// Loop
		for object in result as! [NSManagedObject] {
			print(object.value(forKey: "name") as! String)
			print(object.value(forKey: "country") as! String)
		}
		print("Core Data: Get Successful")
	} catch {
		print("Core Data: Get - \(error)")
	}
}


///////////////////////// Delete Core Data /////////////////////////
func deleteCoreData(entity: String, key: String, value: String) {
	/// Set Entity of Data
	entityName = entity
	
	/// Request Settings and Criteria
	request.predicate = NSPredicate(format: "\(key) = '\(value)'")
	request.returnsObjectsAsFaults = false // Cache
	
	/// Delete Data based on Request
	do {
		// Fetch
		let result = try context.fetch(request)
		// Loop
		for object in result {
			context.delete(object as! NSManagedObject)
		}
		print("Core Data: Deleted")
	} catch {
		print("Core Data: Delete - \(error)")
	}
}
