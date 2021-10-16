//
//  CoreDataManager.swift
//  hashKeyboard
//
//  Created by Juyeon on 2021/10/16.
//

import UIKit
import CoreData

enum CoreDataName: String {
    case tag = "Tag"
}

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var context = appDelegate?.persistentContainer.viewContext
    
    func saveTag(key: String, value: String, completion: @escaping (Bool) -> Void) {
        guard let context = self.context,
            let entity = NSEntityDescription.entity(forEntityName: CoreDataName.tag.rawValue, in: context)
            else { return }

        guard let tag = NSManagedObject(entity: entity, insertInto: context) as? Tag else { return }
        
        tag.id = UUID()
        tag.key = key
        tag.value = value

        do {
            try context.save()
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func loadFromCoreData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        guard let context = self.context else { return [] }
        do {
            let results = try context.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func delete<T: NSManagedObject>(at id: UUID, request: NSFetchRequest<T>) -> Bool {
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)

        do {
            if let data = try context?.fetch(request) {
                if data.count == 0 { return false }
                context?.delete(data[0])
                try context?.save()
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }

        return false
    }


}
