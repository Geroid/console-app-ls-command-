//
//  Utility.swift
//  Console app ls command
//
//  Created by Viktor Rezvantsev on 02.03.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation

enum OptionType: String {
    case hiddenFiles = "a"
    case additionalInfo = "l"
    case help = "h"
    case unknown
    
    init(value: String) {
        switch value {
        case "a": self = .hiddenFiles
        case "l": self = .additionalInfo
        case "h": self = .help
        default: self = .unknown
        }
    }
}

class Utility {
    let consoleIO = ConsoleIO()
    
    func staticMode() {
        let argCount = CommandLine.argc
        let argument = CommandLine.arguments[1]
        let (option, value) = getOption(argument.substring(from: argument.index(argument.startIndex, offsetBy: 1)))
        switch option {
        case .additionalInfo:
            if argCount != 2 {
                if argCount > 2 {
                    consoleIO.writeMessage("Too many arguments for option \(option.rawValue)", to: .error)
                } else {
                    consoleIO.writeMessage("Too few arguments for option \(option.rawValue)", to: .error)
                }
            }
            else {
                let s = CommandLine.arguments[1]
                s.additionalLs()
            }
        case .hiddenFiles:
            if argCount != 2 {
                if argCount > 2 {
                    consoleIO.writeMessage("Too many arguments for option \(option.rawValue)", to: .error)
                } else {
                    consoleIO.writeMessage("Too few arguments for option \(option.rawValue)", to: .error)
                }
            }
            else {
                let s = CommandLine.arguments[1]
                s.hiddenLs()
            }
        case .help:
                consoleIO.printUsage()
        case.unknown:
            consoleIO.writeMessage("Unkown option \(value)")
            consoleIO.printUsage()
        }
    }
    
    func interactiveMode() {
         defaultLs()
    }
    
    func getOption(_ option: String) -> (option: OptionType, value: String) {
        return (OptionType(value: option), option)
    }
}
