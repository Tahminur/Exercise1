//
//  main.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/24/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(UserTimeout.self),
    NSStringFromClass(AppDelegate.self)
)
