//
//  CoreDataManager+Operations.swift
//  ProductListTask
//
//  Created by Chirag Bhutani on 28/04/20.
//  Copyright © 2020 Chirag Bhutani. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func fetchProducts() -> [Product]?
    func insert(productItem: ProductItem) -> Product?
    func update(product: Product, updatedProductItem : ProductItem) -> Product?
    func deleteItem(product: Product) -> Bool
}

extension CoreDataManager: CoreDataManagerProtocol {
    
    func fetchProducts() -> [Product]?{
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Product")
        do {
            let products = try managedContext.fetch(fetchRequest)
            return products as? [Product]
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }

    
    func insert(productItem: ProductItem) -> Product?{
        let managedContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: managedContext)!
        let product = NSManagedObject(entity: entity, insertInto: managedContext) as? Product
        
        product?.title = productItem.title
        product?.descriptionProduct = productItem.description
        product?.unitPrice = productItem.unitPrice
        product?.quantity = productItem.quantity
        
        do {
            try managedContext.save()
            return product
        } catch let error as NSError {
            debugPrint("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }

    func update(product: Product, updatedProductItem : ProductItem) -> Product?{

        product.title = updatedProductItem.title
        product.descriptionProduct = updatedProductItem.description
        product.quantity = updatedProductItem.quantity
        product.unitPrice = updatedProductItem.unitPrice
        
        let managedContext = self.persistentContainer.viewContext
        do {
            try managedContext.save()
            return product
            
        } catch {
            debugPrint("There is an error in deleting records")
            return nil
        }
    }

    
    func deleteItem(product: Product) -> Bool{

        let managedContext = self.persistentContainer.viewContext
        do {
            managedContext.delete(product)
            try managedContext.save()
        } catch {
            debugPrint("There is an error in deleting records")
            return false
        }
        return true
    }
    
    func checkIfProductExists(title : String)->Bool{
        
        let managedContext = self.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)

        var entitiesCount = 0

        do {
            entitiesCount = try managedContext.count(for: fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        return entitiesCount > 0
    }
}

