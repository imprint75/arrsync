//
//  AppDelegate.swift
//  ArrSync
//
//  Created by sean smith on 8/25/14.
//  Copyright (c) 2014 ssjc. All rights reserved.
//

import Cocoa


class SyncMetaData {
    var origin: String?
    var target: String?
    var syncStatus = false
}

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var originDirectory: NSTextField!
    @IBOutlet weak var targetDirectory: NSTextField!
    
    var syncOption = SyncMetaData()

    @IBAction func originBtnPressed(sender: NSButton) {
        originDirectory.stringValue = getAbsoluteURLOfDirectory()
        syncOption.origin = originDirectory.stringValue
    }
    
    @IBAction func targetBtnPressed(sender: NSButton) {
        targetDirectory.stringValue = getAbsoluteURLOfDirectory()
        syncOption.target = targetDirectory.stringValue
    }
    
    @IBAction func syncButtonPressed(sender: NSButton) {
        if let syncOrigin = syncOption.origin? {
            getFileNamesFromDirectory(syncOrigin)
        }
        
    }
    
    func getFileNamesFromDirectory(path: String) {
        var error: NSError? = nil
        let fileManager = NSFileManager.defaultManager()
        let contents = fileManager.contentsOfDirectoryAtPath(path, error: &error)
        if contents != nil {
            let filenames = contents as [String]
            for item in filenames {
                println(item)
            }
        }
    }
    
    func getAbsoluteURLOfDirectory() -> String {
        let directorySelectDiag: NSOpenPanel = NSOpenPanel()
        directorySelectDiag.allowsMultipleSelection = false
        directorySelectDiag.canChooseFiles = false
        directorySelectDiag.canChooseDirectories = true
        directorySelectDiag.runModal()
        
        //var selected: String = directorySelectDiag.URL.absoluteString!
        
        // Use path to show directory location
        var selected: String = directorySelectDiag.URL.path!
        NSLog("%@", selected)
        return selected
    }

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}

