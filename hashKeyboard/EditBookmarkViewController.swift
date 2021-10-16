//
//  EditViewController.swift
//  hashKeyboard
//
//  Created by Juyeon on 2021/10/16.
//

import UIKit
import RxSwift

class EditBookmarkViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var close: UIBarButtonItem!
    @IBOutlet weak var done: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        close.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
        done.rx.tap
            .asDriver()
            .drive(onNext: {
                let data = CoreDataManager.shared.loadFromCoreData(request: Tag.fetchRequest())
                guard let uuid = data.first?.id else { return }
                let result = CoreDataManager.shared.delete(at: uuid, request: Tag.fetchRequest())
                print(123)
            }).disposed(by: disposeBag)
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
