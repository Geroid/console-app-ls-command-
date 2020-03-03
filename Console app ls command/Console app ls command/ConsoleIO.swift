//
//  ConsoleIO.swift
//  Console app ls command
//
//  Created by Viktor Rezvantsev on 02.03.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation

enum OutputType {
    case error
    case standart
}


class ConsoleIO {
    func writeMessage(_ message: String, to: OutputType = .standart)
    {
        switch to {
        case .standart:
            print("\u{001B}[;m\(message)")
        case .error:
            fputs("u{001B}[0;31m\(message)\n", stderr)
        }
    }
    
    func printUsage() {
        
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        writeMessage("usage:")
        writeMessage("\(executableName) -a")
        writeMessage("or")
        writeMessage("\(executableName) -l")
        writeMessage("or")
        writeMessage("\(executableName) -h to show usage information")
        writeMessage("Type \(executableName) without an option to enter interactive mode.")
    }
}
