//
//  PlayerPersonalSetupRouter.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 31/07/2024.
//

import Foundation
import SwiftUI

protocol PlayerPersonalSetupRoutingLogic {
    func routeToPlayground(info: PlayerInfoModel)
}

protocol PlayerPersonalSetupDataPassing {
    var dataStore: PlayerPersonalSetupDataStore? { get }
}

final class PlayerPersonalSetupRouter: NSObject, PlayerPersonalSetupDataPassing {
    // MARK: - Object lifecycle
    override init() {
        CustomLogger.logInit(owner: String(describing: PlayerPersonalSetupRouter.self))
    }
    
    // MARK: - Deinit
    deinit {
        CustomLogger.logDeinit(owner: String(describing: PlayerPersonalSetupRouter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var navigationPathHolder: NavigationPathHolder?
    var dataStore: PlayerPersonalSetupDataStore?
}

// MARK: - Methods

// MARK: Private
private extension PlayerPersonalSetupRouter {}

// MARK: Public
extension PlayerPersonalSetupRouter {}

// MARK: - Routing Logic
extension PlayerPersonalSetupRouter: PlayerPersonalSetupRoutingLogic {
    func routeToPlayground(info: PlayerInfoModel) {
        navigationPathHolder?.path.append(Destination.playground(info))
    }
}
