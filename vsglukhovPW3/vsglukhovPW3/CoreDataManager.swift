//
//  CoreDataManager.swift
//  vsglukhovPW3
//
//  Created by Valentin Glukhov on 17.03.2024.
//

import UIKit
import CoreData

// MARK: - CRUD ( Create Read Update Delete)
public final class CoreDataManager: NSObject {

    public static let shared = CoreDataManager()
    
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    private func increaseIds(id: Int32) {
        fetchWishes().forEach({ if ($0.id > id) { $0.id -= 1} })
        
        appDelegate.saveContext()
    }
    

    public func createWish(text: String, id: Int32) {
        guard let wishEntityDescription = NSEntityDescription.entity(forEntityName: "Wish", in: context) else { return }
        let wish = Wish(entity: wishEntityDescription, insertInto: context)
        wish.wish = text
        wish.id = id
        
        appDelegate.saveContext()
    }
    
    public func fetchWishes() -> [Wish] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        
        do {
            return (try? context.fetch(fetchRequest) as? [Wish]) ?? []
        }
    }
    
    public func updateWish(text: String, id: Int32){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        do {
            guard let wishes = try? context.fetch(fetchRequest) as? [Wish],
                  let wish = wishes.first(where: { $0.id == id }) else { return }
            wish.wish = text
        }
        
        appDelegate.saveContext()
    }
    
    public func updateWishId(oldId: Int32, newId: Int32){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        do {
            guard let wishes = try? context.fetch(fetchRequest) as? [Wish],
                  let wish = wishes.first(where: { $0.id == oldId }) else { return }
            wish.id = newId
        }
        
        appDelegate.saveContext()
    }
    
    public func deleteWish(id: Int32){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        do {
            guard let wishes = try? context.fetch(fetchRequest) as? [Wish],
                  let wish = wishes.first(where: { $0.id == id }) else { return }
            context.delete(wish)
        }
        
        appDelegate.saveContext()
        increaseIds(id: id)
    }
    
    public func deleteAllWishes() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        do {
            let wishes = try? context.fetch(fetchRequest) as? [Wish]
            wishes?.forEach {context.delete($0)}
        }
        
        appDelegate.saveContext()
    }
}
