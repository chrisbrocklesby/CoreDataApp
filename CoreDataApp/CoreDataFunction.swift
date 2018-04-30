import UIKit
import CoreData

///////////////////////// Section /////////////////////////

func insertCoreData(){
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		let setData = ToDoCoreData(entity: ToDoCoreData.entity(), insertInto: coreData)
		setData.name = "Goto Mary"
		setData.important = true
		print("Data Saved...")
		try? coreData.save()
	}
	
}

///////////////////////// Section /////////////////////////

func getCoreData(entity: String, completion: @escaping (_ response: ToDoCoreData?, _ error: String?) -> Void = { _,_  in }) {
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoCoreData")
		request.returnsObjectsAsFaults = false // Cache
		request.predicate = NSPredicate(format: "name = 'Goto Mary'")
		
		let result = try? coreData.fetch(request)
		if let data = result {
			let response = data.first
			completion(response as? ToDoCoreData, nil)
		}
	}
}
