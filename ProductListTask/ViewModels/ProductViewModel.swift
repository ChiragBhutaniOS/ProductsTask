//
//  ProductViewModel.swift
//  ProductListTask
//
//  Created by Chirag Bhutani on 28/04/20.
//  Copyright © 2020 Chirag Bhutani. All rights reserved.
//

import Foundation

struct ProductViewModel{
    
    var coreDataManager: CoreDataManagerProtocol = CoreDataManager.sharedInstance
    weak var productListDataSource : ProductListDataSource?
    
    var refreshTable: (() -> Void)?

    
    init( dataSource: ProductListDataSource) {
        self.productListDataSource = dataSource
    }

    func fetchDeliveries(){
        
        if let products = coreDataManager.fetchProducts() {
            self.productListDataSource?.products = products
            self.refreshTable?()
        }
    }
}

