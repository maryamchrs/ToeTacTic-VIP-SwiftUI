//
//  AppDelegate.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 30/07/2024.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    private(set) var dependencyContainer = DependencyContainer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
