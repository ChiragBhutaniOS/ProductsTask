//
//  ProductListDataSource.swift
//  ProductListTask
//
//  Created by Chirag Bhutani on 06/05/20.
//  Copyright © 2020 Chirag Bhutani. All rights reserved.
//

import Foundation
import UIKit

let cellIdentifier = "productCell"


class ProductListDataSource : NSObject, UITableViewDataSource {
    
    var products = [Product]();
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        let product = self.products[indexPath.row]
        cell.textLabel?.text = product.title
        
        return cell
    }

}
