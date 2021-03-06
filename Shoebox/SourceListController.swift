//
//  SourceListController.swift
//  Shoebox
//
//  Created by David Kennedy on 10/04/2016.
//  Copyright © 2016 David Kennedy of Zenopolis. All rights reserved.
//

import Cocoa

class SourceListController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    // MARK: - Types
    
    struct CellName {
        static let title = "TitleCell"
    }
    
    struct ColumnName {
        static let title = "Title"
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: NSTableView!
    
    // MARK: - Data Controller Access
    
    override var representedObject: AnyObject? {
        didSet {
            updateView()
        }
    }

    var dataController: DataController! {
        return representedObject as! DataController
    }
    
    // MARK: Helper Methods
    
    func updateView() {
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func addItem(sender: AnyObject) {
        dataController.library.addItemWithTitle(self.dateStamp())
        updateView()
    }
    
    // MARK: Helper Methods
    
    private func dateStamp() -> String {
        
        let currentDateTime = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        let dateString = dateFormatter.stringFromDate(currentDateTime)
        
        return dateString
    }

    // MARK: - NSTableView Data Source - Getting Values
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        
        if ( representedObject == nil ) { return 0 }
        return (dataController.library.items?.count)!
    }
    
    // MARK: - NSTableView Delegate - Providing Views
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let item = dataController.library.items?[row] as! Item
        let tableCellView = tableView.makeViewWithIdentifier(CellName.title, owner: self) as! NSTableCellView
        tableCellView.textField?.stringValue = item.title!
        return tableCellView
    }
    
    // MARK: - NSTableView Delegate - Selecting Rows
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        
        let row = tableView.selectedRow
        
        if (row >= 0) { // something selected
            
            let selectedItem = dataController.library.itemForIndex(row)
            
            if (dataController.library.selectedItem != selectedItem) { // if the actual selected object has changed
                dataController.library.selectedItem = selectedItem
            }
            
        } else { // nothing selected
            
            dataController.library.selectedItem = nil
        }
    }

}

