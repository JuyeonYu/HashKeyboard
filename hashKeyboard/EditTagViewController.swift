//
//  EditTagViewController.swift
//  hashKeyboard
//
//  Created by Juyeon on 2021/10/16.
//

import UIKit
import CoreData

class EditTagViewController: UIViewController {
    @IBOutlet weak var close: UIBarButtonItem!
    @IBOutlet weak var done: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.shared.saveTag(key: "test", value: "done?") {
            if $0 {
                print(123)
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let data = CoreDataManager.shared.loadFromCoreData(request: Tag.fetchRequest())
        print(123)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
