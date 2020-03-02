//
//  showFiles.swift
//  Console app ls command
//
//  Created by Viktor Rezvantsev on 02.03.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation

struct FileDescription: Codable {
    var ownerAccountName: String
    var referenceCount: Int
    var fileSize: UInt64
    var modificationDate: Date
    var fileName: String
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

func attributes(url: String) -> String
{
    let fileAttributes = try! fm.attributesOfItem(atPath: url)
    // need fix result var style
    let result: String = "\(fileAttributes[.ownerAccountName] ?? "NOT FOUND") "
        + "\(fileAttributes[.referenceCount] ?? "NO REFERENCE") "
        + "\(fileAttributes[.modificationDate] ?? "WRONG DATE") "
        + "\(fileAttributes[.size] ?? "WRONG SIZE")"
    return result
}

func additionalLs() {
    do {
        let files = try fm.contentsOfDirectory(atPath: path)
        for file in files {
            print("\(file) \(attributes(url: file))")
        }
    } catch {
        print("Permission denied")
    }
}

func hiddenLs() {
    let docUrl = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    do {
        let items = try fm.contentsOfDirectory(at: docUrl, includingPropertiesForKeys: nil)
        
        for item in items {
            print("\(item)")
        }
    } catch {
        print("Permission denied")
    }
}
