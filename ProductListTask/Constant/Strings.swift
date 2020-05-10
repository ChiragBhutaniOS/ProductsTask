//
//  Strings.swift
//  ProductListTask
//
//  Created by Chirag Bhutani on 06/05/20.
//  Copyright © 2020 Chirag Bhutani. All rights reserved.
//

import Foundation

struct ConstantString {
    private init() {}
    static let productListTitle = "Product list"
    static let addProductTitle = "Add new product"
    static let editProductTitle = "Edit product"
    static let noProductsMessage = "No products"
    static let saveButtonText = "Save"
    static let deleteButtonText = "Delete"

    static let titleEmptyWarningText = "Title cannot be left blank"
    static let descriptionEmptyWarningText = "Description cannot be left blank"
    static let priceEmptyWarningText = "Price cannot be left blank"
    static let quantityEmptyWarningText = "Quantity cannot be left blank"
    
    static let productSavedMessage = "Product saved successfully"
    static let productUpdatedMessage = "Product updated successfully"
    static let productDeletedMessage = "Product deleted successfully"
    static let errorGenericMessage = "An error occured"
    static let errorProductAlreadyExists = "A product with same title already exists"
    static let errorProductNotDeleted = "The product could not be deleted"
    static let errorProductFieldsNotChanged = "No value changed"

}
