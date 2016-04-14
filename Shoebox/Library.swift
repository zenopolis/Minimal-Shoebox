//
//  Library.swift
//  Shoebox
//
//  Created by David Kennedy on 10/04/2016.
//  Copyright © 2016 David Kennedy of Zenopolis. All rights reserved.
//

import Foundation
import CoreData

@objc(Library)
class Library: NSManagedObject {

    // MARK: - Property Names
    
    struct Relationship {
        static let items = "items"
    }
    
    // MARK: - Observable State
    
    struct ObservableProperty {
        static let selectedItem = "selectedItem"
    }
    
    dynamic var selectedItem: Item! = nil
    
    // MARK: - Methods
    
    func addItemWithTitle(title: String) {
        
        if let items = items as? NSMutableOrderedSet {
            
            let item = NSEntityDescription.insertNewObjectForEntityForName(Model.Entity.item, inManagedObjectContext: self.managedObjectContext!) as! Item
            
            item.title = title
            item.content = ""
            
            item.parent = self
            
            items.addObject(item)
        }
    }
    
    // MARK: - Items Accessor Methods
    
    func itemForIndex(idx: Int) -> Item! {
        
        if let item = items?.objectAtIndex(idx) as? Item {
            return item
        }
        return nil
    }
    
}
