//
//  AppDelegate.swift
//  ArrSync
//
//  Created by sean smith on 8/25/14.
//  Copyright (c) 2014 ssjc. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet weak var window: NSWindow!

    @IBAction func originBtnPressed(sender: NSButton) {
        let originDialog: NSOpenPanel = NSOpenPanel()
        originDialog.allowsMultipleSelection = false
        originDialog.canChooseDirectories = true
        originDialog.runModal()
    
        var selected: String = originDialog.URL.absoluteString!
        NSLog("%@", selected)
    }

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}

