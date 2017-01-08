//
//  ItemsTableViewController.swift
//  Homepwner
//
//  Created by David on 12/29/16.
//  Copyright © 2016 DSmith. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    // TableView DataSource - Injected with Dependency Inversion - See AppDelegate.Swift
    var itemStore: ItemStore!
    
    private let REUSE_IDENTIFIER: String! = "UITableViewCell"
    private let NO_MORE_ITEMS: String! = "No more Items!"
    
    private let EDIT: String! = "Edit"
    private let DONE: String! = "Done"
    
    private let REMOVE_MESSAGE: String! = "Are you sure you want to remove this item?"
    private let REMOVE: String! = "Remove"
    private let CANCEL: String! = "Cancel"
    private let EMPTY_STRING: String! = ""
    
    @IBAction func addNewItem(sender: AnyObject) {
        // Add a new item to the ItemStore
        let newItem = itemStore.createItem()
        itemStore.addItem(item: newItem)
        
        // If the Item is successfully placed in the ItemStore, update the IndexPath for the View
        if let index = itemStore.getIndexOfItem(item: newItem) {
            let indexPath = NSIndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        // Using the isEditing property on UITableViewController for editing table view
        if self.isEditing {
            sender.setTitle(EDIT, for: .normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle(DONE, for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Content Insets - Dynamic Inset for other attributes on the device (e.g. the status bar)
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        // This one sets the View Initially
        tableView.contentInset = insets
        // This one sets the View for Scrolling
        tableView.scrollIndicatorInsets = insets
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemStore.getCount() + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath)
        if indexPath.row == itemStore.getCount() {
            cell.textLabel?.text = NO_MORE_ITEMS
            cell.detailTextLabel?.text = EMPTY_STRING
            return cell
        }
        // Configure the cell...
        let item = itemStore.getItemAtIndex(index: indexPath.row)
        
        cell.textLabel?.text = item.getName()
        cell.detailTextLabel?.text = item.getValue()
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.row == itemStore.getCount() {
            return false
        }
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = itemStore.getItemAtIndex(index: indexPath.row)
            let title = "Remove \(itemToDelete.getName())"
            let message = REMOVE_MESSAGE
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: CANCEL, style: .cancel, handler: nil)
        
            let deleteAction = UIAlertAction(title: REMOVE, style: .destructive, handler: {
                (action) in
                // Delete the row from the View and the ItemStore
                self.itemStore.removeItem(item: itemToDelete)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(cancelAction)
            ac.addAction(deleteAction)
            
            // Present the Alert View on the TableView
            present(ac, animated: true, completion: nil)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            // Useful is manually adding in item
        }    
    }
    
    // Sets Text for Delete Functionality
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return REMOVE
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        itemStore.moveItemAtIndex(fromIndex: fromIndexPath.row, toIndex: to.row)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        if indexPath.row == itemStore.getCount() {
            return false
        }
        return true
    }
    
    // Used to prevent moving cell beyond final cell -> "No More Items!"
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row < itemStore.getCount() {
            return proposedDestinationIndexPath
        }
        return sourceIndexPath
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
