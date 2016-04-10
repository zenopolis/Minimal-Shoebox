//
//  SplitViewController.swift
//  Shoebox
//
//  Created by David Kennedy on 10/04/2016.
//  Copyright © 2016 David Kennedy of Zenopolis. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    // MARK: - Data Controller Access
    
    override var representedObject: AnyObject? {
        didSet {
            injectDataController()
        }
    }
    
    // MARK: Helper Methods
    
    func injectDataController() {
        
        for childViewController in childViewControllers {
            childViewController.representedObject = representedObject
        }
    }
    
}
