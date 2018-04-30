import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		insertCoreData()
		getCoreData(entity: "Code") { (response, error) in
			print(response?.name)
		}
	}

}

