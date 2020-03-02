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
    case def
    
    init(value: String) {
        switch value {
        case "a": self = .hiddenFiles
        case "l": self = .additionalInfo
        case "h": self = .help
        default: self = .def
        }
    }
}

class Utility {
    let consoleIO = ConsoleIO()
    
    func staticMode() {
        let argCount = CommandLine.argc
        let argument = CommandLine.arguments[2]
        let (option, value) = getOption(argument.substring(from: argument.index(argument.startIndex, offsetBy: 1)))
        switch option {
        case .hiddenFiles:
            hiddenLs()
        case .additionalInfo:
            additionalLs()
        case .help:
            consoleIO.printUsage()
        default:
            defaultLs()
        }
    }
    
    func getOption(_ option: String) -> (option: OptionType, value: String) {
        return (OptionType(value: option), option)
    }
}
