//
//  DetailViewController.swift
//  Shoebox
//
//  Created by David Kennedy on 10/04/2016.
//  Copyright © 2016 David Kennedy of Zenopolis. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController {

    // MARK: - Outlets
    
    @IBOutlet var textView: NSTextView!
    
    // MARK: Lifecycle
    
    override func viewDidDisappear() {
        super.viewWillDisappear()
        
        storeTextChanges()
    }
    
    deinit {
        if let library = dataController.library {
            library.removeObserver(self, forKeyPath: Model.Properties.State.selectedItem)
        }
    }
    
    // MARK: - Data Controller Access
    
    override var representedObject: AnyObject? {
        didSet {
            registerAsObserver()
            updateView()
        }
    }
    
    var dataController: DataController! {
        return representedObject as! DataController
    }
    
    // MARK: Helper Methods
    
    func registerAsObserver() {
        dataController.library.addObserver(self, forKeyPath: Model.Properties.State.selectedItem, options: .New, context: nil)
    }
    
    func updateView() {
        if let text = dataController.library.selectedItem.content {
            textView.string = text
        }
    }
    
    // MARK: - NSText Delegate - Editing Text
    
    var textHasChanged = false
    
    func textDidBeginEditing(notification: NSNotification) {
        textHasChanged = true
    }
    
    func textDidEndEditing(notification: NSNotification) {
        storeTextChanges()
    }
    
    // MARK: Helper Methods
    
    private func storeTextChanges() {
        
        if textHasChanged {
            if let item = dataController.library.selectedItem {
                item.content = textView.string
            }
            textHasChanged = false
        }
    }
    
    // MARK: - Key Value Observing
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if (keyPath == Model.Properties.State.selectedItem) {
            updateView()
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }

}
