import UIKit
import CoreData

///////////////////////// Section /////////////////////////

func insertCoreData(){
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		let toDo = ToDoCoreData(entity: ToDoCoreData.entity(), insertInto: coreData)
		toDo.name = "Goto Mary"
		toDo.important = true
		try? coreData.save()
	}
	
}

///////////////////////// Section /////////////////////////

func getCoreData(){
	if let coreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
		let coreDataToDos = try? coreData.fetch(ToDoCoreData.fetchRequest()) as? [ToDoCoreData]
			if let theToDos = coreDataToDos {
				print(theToDos?.last?.name)
			}
		
	}
}
