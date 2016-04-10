//
//  ViewController.swift
//  Shoebox
//
//  Created by David Kennedy on 10/04/2016.
//  Copyright © 2016 David Kennedy of Zenopolis. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

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
        // TODO: Implement updateView
    }
    
}

