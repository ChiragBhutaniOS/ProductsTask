//
//  AddProductViewModel.swift
//  ProductListTask
//
//  Created by Chirag Bhutani on 07/05/20.
//  Copyright © 2020 Chirag Bhutani. All rights reserved.
//

import Foundation
import UIKit

struct AddProductViewModel{
    
    var coreDataManager: CoreDataManagerProtocol = CoreDataManager.sharedInstance
    var product : Product?
    
    
    init( product: Product?) {
        self.product = product
    }

    func insertProduct(productItem : ProductItem) -> Product?{
        
        if let product = coreDataManager.insert(productItem: productItem) {
            
            refrestProductListTable()
            return product
        }
        return nil
    }
    
    func updateProduct(product : Product, productItem : ProductItem) -> Product?{
        
        if let product = coreDataManager.update(product: product, updatedProductItem: productItem){
            refrestProductListTable()
            return product
        }
        return nil
    }
    
    func deleteProduct(product : Product) -> Bool {
        
        let isDeleteSuccess = coreDataManager.deleteItem(product: product)
        if (isDeleteSuccess){
            refrestProductListTable()
            return true
        }
        return false
    }

    func productAlreadyExists(title: String) -> Bool {
        
        return CoreDataManager.sharedInstance.checkIfProductExists(title: title)
    }
    
    private func refrestProductListTable() {

        let navigationController = AppDelegate.delegate().window?.rootViewController as! UINavigationController
        let productListViewController = navigationController.viewControllers.first as! ProductListTableViewController
        productListViewController.productViewModel.fetchDeliveries()
    }

}
