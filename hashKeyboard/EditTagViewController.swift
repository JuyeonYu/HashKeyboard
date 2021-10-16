//
//  EditTagViewController.swift
//  hashKeyboard
//
//  Created by Juyeon on 2021/10/16.
//

import UIKit
import CoreData
import RxSwift

class EditTagViewController: UIViewController {
    var disposeBag = DisposeBag()
    var tag: Tag?
    @IBOutlet weak var close: UIBarButtonItem!
    @IBOutlet weak var done: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        close.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        CoreDataManager.shared.saveTag(key: "test", value: "done?") {
            if $0 {
                print(123)
            }
        }
        rx.viewWillDisappear
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: {
                    let top = UIApplication.topViewController() as? TagsViewController
                    top?.reactor?.action.onNext(.loadTags)
                    
                })
            }).disposed(by: disposeBag)
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
