//
//  Model.swift
//  Shoebox
//
//  Created by David Kennedy on 10/04/2016.
//  Copyright © 2016 David Kennedy of Zenopolis. All rights reserved.
//

// MARK: Types

struct Model {
    
    struct Entities {
        
        static let item             = "Item"
        static let library          = "Library"
    }
    
    struct Properties {
        
        struct Attributes {
            
            static let content      = "content"
            static let title        = "title"
        }
        
        struct Relationships {
            
            static let parent       = "parent"
            static let items        = "items"
        }
        
    }
    
    struct FetchRequest {
        
        static let library          = "Library"
    }
    
    struct Serialization {
        
        static let entityName       = "entityName"
    }
    
}