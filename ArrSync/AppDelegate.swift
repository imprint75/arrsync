//
//  AppDelegate.swift
//  ArrSync
//
//  Created by sean smith on 8/25/14.
//  Copyright (c) 2014 ssjc. All rights reserved.
//

import Cocoa
import Foundation


class SyncMetaData {
    var origin: NSURL?
    var target: NSURL?
    var syncStatus = false
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var originDirectory: NSTextField!
    @IBOutlet weak var targetDirectory: NSTextField!
    @IBOutlet weak var statusMessage: NSTextField!
    
    var syncOption = SyncMetaData()

    @IBAction func originBtnPressed(sender: NSButton) {
        let originDirectoryURL = getAbsoluteURLOfDirectory()
        originDirectory.stringValue = originDirectoryURL.path
        syncOption.origin = originDirectoryURL
    }
    
    @IBAction func targetBtnPressed(sender: NSButton) {
        let targetDirectoryURL = getAbsoluteURLOfDirectory()
        targetDirectory.stringValue = targetDirectoryURL.path
        syncOption.target = targetDirectoryURL
    }
    
    @IBAction func syncButtonPressed(sender: NSButton) {
        if let syncOrigin = syncOption.origin? {
            if let syncTarget = syncOption.target? {
                var error: NSError? = nil
                let filesInOrigin = getFileNamesFromDirectory(syncOrigin.path!)
                let fileCopyManager = NSFileManager.defaultManager()
                
                for item in filesInOrigin {
                    let origPath: String! = syncOrigin.path?.stringByAppendingPathComponent(item)
                    let destPath: String! = syncTarget.path?.stringByAppendingPathComponent(item)
                    
                    if fileCopyManager.fileExistsAtPath(destPath) {
                        appendStatusMessage("File exists " + destPath)
                        NSLog("File exists %@", destPath)
                    } else {
                        let success = fileCopyManager.copyItemAtPath(origPath, toPath: destPath, error: &error)
                        if success {
                            appendStatusMessage("File copied to " + destPath)
                        }
                        
                        if let err = error {
                            appendStatusMessage(err.localizedDescription)
                        }
                    }
                }
                if let err = error {
                    appendStatusMessage(err.localizedDescription)

                }
            }
        }
    }
    
    func appendStatusMessage(msg: String){
        let updatedMsg = statusMessage.stringValue.stringByAppendingString(msg + "\n")
        statusMessage.stringValue = updatedMsg
    }
    
    func getFileNamesFromDirectory(path: String) -> [String]{
        var error: NSError? = nil
        var filenames = [String]()
        let fileManager = NSFileManager.defaultManager()
        let contents = fileManager.contentsOfDirectoryAtPath(path, error: &error)
        if contents != nil {
            filenames = contents as [String]
            for item in filenames {
                println(item)
            }
        }
        return filenames
    }
    
    func getAbsoluteURLOfDirectory() -> NSURL {
        let directorySelectDiag: NSOpenPanel = NSOpenPanel()
        directorySelectDiag.allowsMultipleSelection = false
        directorySelectDiag.canChooseFiles = false
        directorySelectDiag.canCreateDirectories = true
        directorySelectDiag.canChooseDirectories = true
        directorySelectDiag.runModal()
        
        let selected: NSURL = directorySelectDiag.URLs[0] as NSURL
        NSLog("%@", selected)
        return selected
    }

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
//        window.backgroundColor = NSColor.grayColor()
        
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}

