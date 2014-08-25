// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"


func contentsOfDirectoryAtPath(path: String) -> (filenames: String[]?, error: NSError?) {
    var error: NSError? = nil
    let fileManager = NSFileManager.defaultManager()
    let contents = fileManager.contentsOfDirectoryAtPath(path, error: &error)
    if contents == nil {
        return (nil, error)
    }
    else {
        let filenames = contents as String[]
        return (filenames, nil)
    }
}
 
let (filenamesOpt, errorOpt) = contentsOfDirectoryAtPath("/Users")
if let filenames = filenamesOpt {
    filenames               // [".localized", "kris", ...]
}

filenames
