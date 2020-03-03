//
//  showFiles.swift
//  Console app ls command
//
//  Created by Viktor Rezvantsev on 02.03.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation

struct FileDescription: Codable {
    var referenceCount: Int
    var ownerAccountName: String
    var fileSize: UInt64
    var modificationDate: Date
}


let fm = FileManager.default
let path = Bundle.main.resourcePath!


func defaultLs() {
    do {
        let items = try fm.contentsOfDirectory(atPath: path)
        for file in items {
            print("\(file)")
        }
    } catch {
        print("Permission denied")
    }
}

extension String {
    func additionalLs() {
        let path = Bundle.main.resourcePath!
        do {
            let files = try fm.contentsOfDirectory(atPath: path)
            for file in files {
                print("""
                    \(file) \(attributes(url: file).referenceCount) \
                    \(attributes(url: file).ownerAccountName) \
                    \(attributes(url: file).fileSize) \
                    \(attributes(url: file).modificationDate)
                    """)
            }
        } catch {
            print("Permission denied")
        }
    }
    
    func hiddenLs() {
        let skipsFilesHidden = false
        let paths = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let items = try! fm.contentsOfDirectory(at: paths, includingPropertiesForKeys: nil, options: skipsFilesHidden ? .skipsHiddenFiles : [])
        for item in items {
            print("\(item.lastPathComponent)")
        }
    }
}

func attributes(url: String) -> FileDescription
{
    let fileAttributes = try! fm.attributesOfItem(atPath: url)
    let fileDesc = FileDescription(referenceCount: fileAttributes[.referenceCount] as! Int? ?? 0,
                                   ownerAccountName: fileAttributes[.ownerAccountName] as! String? ?? "NOT FOUND",
                                   fileSize: fileAttributes[.size] as! UInt64? ?? 0,
                                   modificationDate: fileAttributes[.modificationDate] as! Date)
    return fileDesc
}
