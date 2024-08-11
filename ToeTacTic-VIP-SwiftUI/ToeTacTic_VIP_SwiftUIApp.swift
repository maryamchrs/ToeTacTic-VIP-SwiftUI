//
//  ToeTacTic_VIP_SwiftUIApp.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 29/07/2024.
//

import SwiftUI

@main
struct ToeTacTic_VIP_SwiftUIApp: App {
    
    @ObservedObject var navigationPathHolder = NavigationPathHolder()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationPathHolder.path) {
                ViewFactory.start(navigationPathHolder: navigationPathHolder)
                    .navigationDestination(for: Destination.self) { destination in
                        ViewFactory.createView(destination, navigationPathHolder: navigationPathHolder)
                    }
            }
        }
    }
}
