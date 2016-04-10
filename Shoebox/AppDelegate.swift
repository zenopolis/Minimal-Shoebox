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
        
        let mainWindow = NSApplication.sharedApplication().windows.first
        if let viewController = mainWindow?.contentViewController {
            viewController.representedObject = dataController
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
    
    func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        
        do {
            try dataController.terminate()
        } catch {
            let nserror = error as NSError
            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .TerminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButtonWithTitle(quitButton)
            alert.addButtonWithTitle(cancelButton)
            
            let answer = alert.runModal()
            if answer == NSAlertFirstButtonReturn {
                return .TerminateCancel
            }
        }
        
        // If we got here, it is time to quit.
        return .TerminateNow
    }

    // MARK: - Data Saving and Undo support

    @IBAction func saveAction(sender: AnyObject!) {
        dataController.save()
    }

    func windowWillReturnUndoManager(window: NSWindow) -> NSUndoManager? {
        return dataController.undoManager()
    }

}

