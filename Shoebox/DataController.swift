//
//  DataController.swift
//  Shoebox
//
//  Created by David Kennedy on 10/04/2016.
//  Copyright © 2016 David Kennedy of Zenopolis. All rights reserved.
//

import Cocoa

class DataController: NSObject {

    // MARK: - Properties
    
    lazy var library: Library! = {
        
        let mom = self.managedObjectModel
        let request = mom.fetchRequestTemplateForName(Model.FetchRequest.library)
        
        var results: [AnyObject]?
        
        do {
            results = try self.managedObjectContext.executeFetchRequest(request!)
        } catch var error as NSError {
            print("Error: \(error.localizedDescription)\n\(error.userInfo)")
            results = nil
        }
        
        if var results = results {
            if results.count != 0 {
                if let library = results[0] as? Library {
                    return library
                }
            }
        }
        
        // Nothing in store - Load our default outline view data.
        return self.freshLibrary()
        }()
    
    // MARK: Helper Methods
    
    private func freshLibrary() -> Library! {
        
        let moc = self.managedObjectContext
        let library = NSEntityDescription.insertNewObjectForEntityForName(Model.Entities.library, inManagedObjectContext: moc) as! Library
        return library
    }
    
    // MARK: - Data Saving and Undo support
    
    func save() {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        if !managedObjectContext.commitEditing() {
            NSLog("\(NSStringFromClass(self.dynamicType)) unable to commit editing before saving")
        }
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSApplication.sharedApplication().presentError(nserror)
            }
        }
    }
    
    func undoManager() -> NSUndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        return managedObjectContext.undoManager
    }
    
    func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        
        if !managedObjectContext.commitEditing() {
            NSLog("\(NSStringFromClass(self.dynamicType)) unable to commit editing to terminate")
            return .TerminateCancel
        }
        
        if !managedObjectContext.hasChanges {
            return .TerminateNow
        }
        
        do {
            try managedObjectContext.save()
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
    
    // MARK: - Core Data stack
    
    private let coreDataStack = CoreDataStack()
    
    private lazy var managedObjectModel: NSManagedObjectModel = { self.coreDataStack.managedObjectModel }()
    private lazy var managedObjectContext: NSManagedObjectContext = { self.coreDataStack.managedObjectContext }()

}
