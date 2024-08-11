//
//  GameDescriptionRouter.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 29/07/2024.
//

import Foundation
import SwiftUI

protocol GameDescriptionRoutingLogic {
    func routeToPlayerPersonalSetupView()
}

protocol GameDescriptionDataPassing {
    var dataStore: GameDescriptionDataStore? { get }
}

final class GameDescriptionRouter: NSObject, GameDescriptionDataPassing {
    // MARK: - Object lifecycle
    override init() {
        CustomLogger.logInit(owner: String(describing: GameDescriptionRouter.self))
    }
    
    // MARK: - Deinit
    deinit {
        CustomLogger.logDeinit(owner: String(describing: GameDescriptionRouter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var navigationPathHolder: NavigationPathHolder?
    var dataStore: GameDescriptionDataStore?
}

// MARK: - Methods

// MARK: Private
private extension GameDescriptionRouter {}

// MARK: Public
extension GameDescriptionRouter {}

// MARK: - Routing Logic
extension GameDescriptionRouter: GameDescriptionRoutingLogic {
    func routeToPlayerPersonalSetupView() {
        navigationPathHolder?.path.append(Destination.personalSetup)
    }
}
