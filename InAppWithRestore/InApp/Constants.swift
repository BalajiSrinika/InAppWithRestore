
//
//  File.swift
//  InAppWithRestore
//
//  Created by Sabari on 04/04/20.
//  Copyright © 2020 Sabari. All rights reserved.
//

import Foundation


/// Product identifier
let appProductIdentifier = ""

// App Name //
let appName = "Restore Demo"

// userdefaults name //
let inAppMode = "In_AppPurchase"

// InAppstatus //
func InAppStatus() -> Bool {
  return UserDefaults.standard.bool(forKey: inAppMode)
}

