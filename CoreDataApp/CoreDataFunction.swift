import UIKit
import CoreData

///////////////////////// Delete Core Data /////////////////////////

func deleteCoreData(entity: String, key: String = "", value: String = ""){
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		
		/// Request Data from CoreData ///
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
		request.returnsObjectsAsFaults = false // Cache
		
		// Add search options to Request
		if key != "" || value != "" {
			request.predicate = NSPredicate(format: "\(key) == %@", value)
		}
		
		/// Fetch Results and Delete ///
		let result = try? coreData.fetch(request)
		for object in result! {
			coreData.delete(object as! NSManagedObject)
			print("Deleted: \(object)")
		}
	}
}

func saveCoreData(){
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
	do {
		try coreData.save()
		print("Core Data: Saved")
		
	} catch {
		print("Core Data: \(error)")
	}
	}
}

///////////////////////// Insert Core Data /////////////////////////

func insertCoreData(entity: String, key: String = "", value: String = ""){
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		let setEntity = NSEntityDescription.entity(forEntityName: entity, in: coreData)
		let insert = NSManagedObject(entity: setEntity!, insertInto: coreData)
		
		insert.setValue(value, forKey: key)
		
		print("Data Saved... \(value)")
		try? coreData.save()
	}
	
}

///////////////////////// View Core Data /////////////////////////

func viewCoreData(entity: String, key: String = "", value: String = "", completion: @escaping (_ response: [NSDictionary], _ error: String?) -> Void = { _,_  in }) {
	/// Connect to CoreData ///
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		
		/// Request Data from CoreData ///
		let request = NSFetchRequest<NSDictionary>(entityName: entity)
		request.returnsObjectsAsFaults = false // Cache
		request.resultType = .dictionaryResultType // Formats into Dictionary
		
		// Add search options to Request
		if key != "" || value != "" {
			request.predicate = NSPredicate(format: "\(key) == %@", value)
		}
		
		/// Fetch Results and include in callback ///
		if let result = try? coreData.fetch(request) {
			completion(result, nil)
		}
	}
}
