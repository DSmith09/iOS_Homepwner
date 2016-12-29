//
//  ItemStore.swift
//  Homepwner
//
//  Created by David on 12/29/16.
//  Copyright © 2016 DSmith. All rights reserved.
//

import UIKit

// Utility Class for Creating/Storing Items
class ItemStore {
    private static var allItems = [Item]()
    
    // Utility Method to Create New Item
    open static func createItem() -> Item {
        return Item(random: true)
    }
    
    // Utility Method to Add New Item to Datastore
    open static func addItem(item: Item) -> Void {
        allItems.append(item)
    }
    
    // Utility Method to Create AND Add New Item to Datastore
    open static func createAndAddItem() -> Void {
        allItems.append(Item(random: true))
    }
    
    open static func getCount() -> Int {
        return allItems.count
    }
    
    // TODO: Add Static Initializer to store 5 elements in Array
}
