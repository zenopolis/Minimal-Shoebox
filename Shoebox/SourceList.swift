//
//  ViewController.swift
//  Shoebox
//
//  Created by David Kennedy on 10/04/2016.
//  Copyright © 2016 David Kennedy of Zenopolis. All rights reserved.
//

import Cocoa

class SourceList: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    // MARK: - Types
    
    struct CellName {
        static let title = "TitleCell"
        static let content = "ContentCell"
    }
    
    struct ColumnName {
        static let title = "Title"
        static let content = "Content"
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
    
    @IBAction func endEditingText(sender: NSTextField) {
        
        let row = tableView.rowForView(sender)
        if (row != -1) {
            if let item = dataController.library.itemForIndex(row) {
                item.content = sender.stringValue
            }
        }
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
        
        var cellName = CellName.title
        if (tableColumn?.identifier == ColumnName.content) {
            cellName = CellName.content
        }
        
        let item = dataController.library.items?[row] as! Item
        
        let tableCellView = tableView.makeViewWithIdentifier(cellName, owner: self) as! NSTableCellView
        
        if (tableColumn?.identifier == ColumnName.title) {
            
            tableCellView.textField?.stringValue = item.title!
            
        } else if (tableColumn?.identifier == ColumnName.content) {
            
            tableCellView.textField?.stringValue = item.content!
        }
        
        return tableCellView
    }

}

