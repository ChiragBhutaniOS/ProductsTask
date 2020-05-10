//
//  ProductListTableViewController.swift
//  ProductListTask
//
//  Created by Chirag Bhutani on 24/04/20.
//  Copyright © 2020 Chirag Bhutani. All rights reserved.
//

import Foundation
import UIKit

class ProductListTableViewController: UITableViewController {
    
    var noDataMessageLabel = UILabel()
    let productListDataSource = ProductListDataSource()
    
    lazy var productViewModel: ProductViewModel = {
        let productViewModel = ProductViewModel(dataSource: productListDataSource)
        return productViewModel
    }()

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        setUpObservers()
    }
    
    private func setup() {
                
        self.tableView.separatorStyle = .none
        
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 80.0))
        noDataLabel.text          = "No products"
        noDataLabel.font = UIFont(name: noDataLabel.font.fontName, size: 24.0)
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        tableView.backgroundView  = noDataLabel
        tableView.dataSource = productListDataSource

    }
    
    
    @IBAction func pushAddProductScreen(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addProductViewController = storyboard.instantiateViewController(withIdentifier: "addProductViewController") as! AddProductViewController
        
        addProductViewController.product = nil
        
        self.navigationController?.pushViewController(addProductViewController, animated: true)
    }
    
}

// MARK: Helper Methods
extension ProductListTableViewController {
    
    private func loadUI() {
        view.backgroundColor = UIColor.white
        self.title = ConstantString.productListTitle
        configureNoDataLabel()
    }
    
    private func configureNoDataLabel() {
        
        noDataMessageLabel.frame  = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 80.0)
        noDataMessageLabel.text          = ConstantString.noProductsMessage
        noDataMessageLabel.font = ApplicationFont.systemBold
        noDataMessageLabel.textColor     = UIColor.lightGray
        noDataMessageLabel.textAlignment = .center
        tableView.backgroundView  = noDataMessageLabel
    }
    
    private func setUpObservers() {
        
        tableView.dataSource = productListDataSource
        
        productViewModel.refreshTable = { [weak self] in
            
            if self?.productListDataSource.products.isEmpty ?? true  {
                self?.tableView.separatorStyle = .none
                self?.tableView.backgroundView = self?.noDataMessageLabel
            }
            else{
                self?.tableView.separatorStyle = .singleLine
                self?.tableView.backgroundView = nil
            }
            self?.tableView.reloadData()
        }
        
        productViewModel.fetchDeliveries()
    }
    
}

// MARK: UITableViewDelegate Methods
extension ProductListTableViewController {
    
    override func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productListDataSource.products[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addProductViewController = storyboard.instantiateViewController(withIdentifier: "addProductViewController") as! AddProductViewController
        addProductViewController.isEditMode = true
        addProductViewController.product = product
        
        self.navigationController?.pushViewController(addProductViewController, animated: true)
    }
    
}

