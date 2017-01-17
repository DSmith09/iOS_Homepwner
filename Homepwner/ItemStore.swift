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
    private var allItems = [Item]()
    private let itemArchiveURL: NSURL = {
        // NOTE: iOS always uses .userDomainMask as SearchFileMask, MacOSX can vary
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("items.archives") as NSURL
    }()
    
    // MARK: Init
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path!) as? [Item] {
            allItems += archivedItems
        }
    }
    // Utility Method to Create New Item
    open func createItem() -> Item {
        return Item(random: true)
    }
    
    // Utility Method to Add New Item to Datastore
    open func addItem(item: Item) -> Void {
        allItems.append(item)
    }
    
    // Utility Method to Create AND Add New Item to Datastore
    open func createAndAddItem() -> Void {
        allItems.append(Item(random: true))
    }
    
    open func getCount() -> Int {
        return allItems.count
    }
    
    open func getItemAtIndex(index: Int) -> Item {
        return allItems[index]
    }
    
    open func getIndexOfItem(item: Item) -> Int? {
        return allItems.index(of: item)
    }
    
    open func removeItem(item: Item) -> Void {
        allItems.remove(at: getIndexOfItem(item: item)!)
    }
    
    open func moveItemAtIndex(fromIndex: Int, toIndex: Int) -> Void {
        if fromIndex == toIndex {
            return
        }
        let movedItem = getItemAtIndex(index: fromIndex)
        removeItem(item: movedItem)
        allItems.insert(movedItem, at: toIndex)
    }
    
    // MARK: Persist Data
    open func saveChanges() -> Bool {
        let urlPath = itemArchiveURL.path!
        print("Saving items to: \(urlPath)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: urlPath)
    }
}
