//
//  AddProductViewController.swift
//  ProductListTask
//
//  Created by Chirag Bhutani on 24/04/20.
//  Copyright © 2020 Chirag Bhutani. All rights reserved.
//

import Foundation
import UIKit

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!

    @IBOutlet weak var btnUpper: UIButton!
    @IBOutlet weak var btnLower: UIButton!
    
    
    var isEditMode = false
    var product : Product?
    
    lazy var addProductViewModel: AddProductViewModel = {
        let addProductViewModel = AddProductViewModel(product: product)
        return addProductViewModel
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
    }
    
    @IBAction func onUpperButtonTapped(_ sender: UIButton) {
        
        if isEditMode {
            updateProduct()
        }
    }
    
    @IBAction func onLowerButtonTapped(_ sender: UIButton) {

        if isEditMode {
            deleteProduct()
        }
        else{
            insertNewProduct()
        }
    }
}

// MARK: Helper Methods
extension AddProductViewController {
    
    
    private func loadUI() {
        view.backgroundColor = UIColor.white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)

        view.isUserInteractionEnabled = true

        if (isEditMode) {
            self.title = ConstantString.editProductTitle
            
            self.btnUpper.setTitle(ConstantString.saveButtonText, for: .normal)
            self.btnLower.setTitle(ConstantString.deleteButtonText, for: .normal)

            self.titleTextField.text = addProductViewModel.product?.title ?? ""
            self.descriptionTextField.text = addProductViewModel.product?.descriptionProduct ?? ""
            
            if let unitPrice = addProductViewModel.product?.unitPrice {
                self.priceTextField.text = String(unitPrice)
            }

            if let quantity = addProductViewModel.product?.quantity {
                self.quantityTextField.text = String(quantity)
            }
        }
        else{
            self.title = ConstantString.addProductTitle
            self.btnUpper.isHidden = true;
            self.btnLower.setTitle(ConstantString.saveButtonText, for: .normal)
        }
    }
    
    private func insertNewProduct() {
        
        if let productItemToInsert = createProductItemFromUserInput(){
            
            if addProductViewModel.productAlreadyExists(title: productItemToInsert.title){

                Utility.sharedInstance.showErrorWithMessage(message: ConstantString.errorProductAlreadyExists)
            }
            else{
                if addProductViewModel.insertProduct(productItem: productItemToInsert) != nil {
                    
                    titleTextField.text = ""
                    descriptionTextField.text = ""
                    priceTextField.text = ""
                    quantityTextField.text = ""

                    Utility.sharedInstance.showErrorWithMessage(message: ConstantString.productSavedMessage, style: .success)
                }
                else{
                    Utility.sharedInstance.showErrorWithMessage(message: ConstantString.errorGenericMessage)
                }
            }
        }
    }

    private func updateProduct() {
        
        if let productItemToUpdate = createProductItemFromUserInput(){
            
            // Check if there is already a product with updated title
            if (productItemToUpdate.title != product?.title && addProductViewModel.productAlreadyExists(title: productItemToUpdate.title)){

                Utility.sharedInstance.showErrorWithMessage(message: ConstantString.errorProductAlreadyExists)
            }
                // Check if any value is changed for updating the product
            else if(productItemToUpdate.title == product?.title && productItemToUpdate.description == product?.descriptionProduct && productItemToUpdate.unitPrice == product?.unitPrice && productItemToUpdate.quantity == product?.quantity){
                
                Utility.sharedInstance.showErrorWithMessage(message: ConstantString.errorProductFieldsNotChanged, style: .success)
            }
            else{
                if addProductViewModel.updateProduct(product: self.product!, productItem: productItemToUpdate) != nil {
                    Utility.sharedInstance.showErrorWithMessage(message: ConstantString.productUpdatedMessage, style: .success)
                    popToProductListViewController()
                }
                else{
                    Utility.sharedInstance.showErrorWithMessage(message: ConstantString.errorGenericMessage)
                }
            }
        }
    }

    private func deleteProduct() {
        
        if let productToDelete = product {
            if(addProductViewModel.deleteProduct(product: productToDelete)){
                Utility.sharedInstance.showErrorWithMessage(message: ConstantString.productDeletedMessage, style: .success)
                popToProductListViewController()
            }
            else {
                Utility.sharedInstance.showErrorWithMessage(message: ConstantString.errorProductNotDeleted, style: .danger)
            }
        }
    }

    
    private func createProductItemFromUserInput() -> ProductItem?{
        
        if (self.titleTextField.text?.isEmpty ?? true) {
            Utility.sharedInstance.showErrorWithMessage(message: ConstantString.titleEmptyWarningText)
        }
        else if (self.descriptionTextField.text?.isEmpty ?? true) {
            Utility.sharedInstance.showErrorWithMessage(message: ConstantString.descriptionEmptyWarningText)
        }
        else if (self.priceTextField.text?.isEmpty ?? true) {
            Utility.sharedInstance.showErrorWithMessage(message: ConstantString.priceEmptyWarningText)
        }
        else if (self.quantityTextField.text?.isEmpty ?? true) {
            Utility.sharedInstance.showErrorWithMessage(message: ConstantString.quantityEmptyWarningText)
        }
        else{
            let title = titleTextField.text!
            let description = descriptionTextField.text!
            let price = Int16(priceTextField.text!)!
            let quantity = Int16(quantityTextField.text!)!
            
            let currentProductItem = ProductItem(title: title, description: description, quantity: quantity, unitPrice: price)
            
            return currentProductItem;
        }
    return nil
    }
    
    private func popToProductListViewController() {
        if let navigationController = self.navigationController{
            navigationController.popViewController(animated: true)
        }
    }
    
    @objc func viewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
    
        view.endEditing(true)
    }
}
