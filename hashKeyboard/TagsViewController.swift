//
//  TagsViewController.swift
//  hashKeyboard
//
//  Created by Juyeon on 2021/10/16.
//

import UIKit
import RxCocoa
import RxSwift
import RxViewController
import ReactorKit

class TagsViewController: UIViewController, StoryboardView {
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var edit: UIBarButtonItem!
    @IBOutlet weak var add: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = TagsReactor()
    }
    
    func bind(reactor: TagsReactor) {
        rx.viewWillAppear
            .map { _ in Reactor.Action.loadTags }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        rx.isDismissing
            .map { _ in Reactor.Action.loadTags }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Tag.self)
            .asDriver()
            .drive(onNext: { [weak self] tag in
                self?.performSegue(withIdentifier: "showEditTag", sender: tag)
            }).disposed(by: disposeBag)
        
        reactor.state
            .map { $0.tags }
            .bind(to: tableView.rx.items) { tableView, row, tag in
                let cell = UITableViewCell()
                cell.textLabel?.text = "\(tag.key): \(tag.value)"
                if row % 2 == 0 {
                    cell.imageView?.image = UIImage(systemName: "checkmark")?.withTintColor(.green).withRenderingMode(.alwaysOriginal)
                } else {
                    cell.imageView?.image = UIImage(systemName: "xmark")?.withTintColor(.red).withRenderingMode(.alwaysOriginal)
                    cell.contentView.backgroundColor = .lightGray
                }
                return cell
            }.disposed(by: disposeBag)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tag = sender as? Tag else { return }
        guard let editViewController = segue.destination as? EditTagViewController else { return }
        editViewController.tag = tag
    }

}
