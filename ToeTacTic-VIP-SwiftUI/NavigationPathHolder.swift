//
//  NavigationPathHolder.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 31/07/2024.
//

import Foundation
import SwiftUI

class NavigationPathHolder: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
}
