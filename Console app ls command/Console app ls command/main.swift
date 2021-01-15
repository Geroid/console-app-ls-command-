//
//  main.swift
//  Console app ls command
//
//  Created by Viktor Rezvantsev on 02.03.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation

let utility = Utility()

if CommandLine.argc < 2 {
    utility.interactiveMode()
} else {
    utility.staticMode()
}
