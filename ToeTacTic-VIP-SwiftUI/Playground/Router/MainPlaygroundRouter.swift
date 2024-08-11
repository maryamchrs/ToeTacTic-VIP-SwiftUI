//
//  MainPlaygroundRouter.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 02/08/2024.
//

import Foundation
import SwiftUI

protocol MainPlaygroundRoutingLogic {
    func routeBack()
}

protocol MainPlaygroundDataPassing {
    var dataStore: MainPlaygroundDataStore? { get }
}

final class MainPlaygroundRouter: NSObject, MainPlaygroundDataPassing {
    // MARK: - Object lifecycle
    override init() {
        CustomLogger.logInit(owner: String(describing: MainPlaygroundRouter.self))
    }
    
    // MARK: - Deinit
    deinit {
        CustomLogger.logDeinit(owner: String(describing: MainPlaygroundRouter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var navigationPathHolder: NavigationPathHolder?
    var dataStore: MainPlaygroundDataStore?
}

// MARK: - Methods

// MARK: Private
private extension MainPlaygroundRouter {}

// MARK: Public
extension MainPlaygroundRouter {}

// MARK: - Routing Logic
extension MainPlaygroundRouter: MainPlaygroundRoutingLogic {
    func routeBack() {
        navigationPathHolder?.path.removeLast()
    }
}
