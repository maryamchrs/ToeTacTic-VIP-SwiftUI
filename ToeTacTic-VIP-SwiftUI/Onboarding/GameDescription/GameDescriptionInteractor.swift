//
//  GameDescriptionInteractor.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 29/07/2024.
//

import Foundation
import Combine

protocol GameDescriptionBusinessLogic {}

protocol GameDescriptionDataStore {}

final class GameDescriptionInteractor: GameDescriptionDataStore {
    
    // MARK: - Object lifecycle
    init() {
        CustomLogger.logInit(owner: String(describing: GameDescriptionInteractor.self))
    }

    // MARK: - Deinit
    deinit {
        CustomLogger.logDeinit(owner: String(describing: GameDescriptionInteractor.self))
    }

    // MARK: - Properties
    
    // MARK: Public
    var presenter: GameDescriptionPresenter?
    var worker: GameDescriptionWorkerLogic?
}

// MARK: - GameDescriptionBusinessLogic
extension GameDescriptionInteractor: GameDescriptionBusinessLogic {}
