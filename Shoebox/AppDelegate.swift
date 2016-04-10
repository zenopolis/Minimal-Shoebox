//
//  AppDelegate.swift
//  Shoebox
//
//  Created by David Kennedy on 10/04/2016.
//  Copyright © 2016 David Kennedy of Zenopolis. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let dataController = DataController()

    // MARK: - Lifecycle
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
    
    func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        return dataController.applicationShouldTerminate(sender)
    }

    // MARK: - Data Saving and Undo support

    @IBAction func saveAction(sender: AnyObject!) {
        dataController.save()
    }

    func windowWillReturnUndoManager(window: NSWindow) -> NSUndoManager? {
        return dataController.undoManager()
    }

}

