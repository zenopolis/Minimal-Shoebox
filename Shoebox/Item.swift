//
//  Item.swift
//  Shoebox
//
//  Created by David Kennedy on 10/04/2016.
//  Copyright © 2016 David Kennedy of Zenopolis. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
class Item: NSManagedObject {

    // MARK: - Property Names
    
    struct Attribute {
        static let content = "content"
        static let title = "title"
    }
    
    struct Relationship {
        static let parent = "parent"
    }

}
