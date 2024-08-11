//
//  GameDescriptionWorker.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 29/07/2024.
//

import Foundation

protocol GameDescriptionWorkerLogic {}

final class GameDescriptionWorker {
    // MARK: - Object lifecycle
    init() {
        CustomLogger.logInit(owner: String(describing: GameDescriptionWorker.self))
    }

    // MARK: - Deinit
    deinit {
        CustomLogger.logDeinit(owner: String(describing: GameDescriptionWorker.self))
    }

    // MARK: - Properties

    // MARK: Private
}

// MARK: - Methods

// MARK: Private
private extension GameDescriptionWorker {}

// MARK: - Worker Logic
extension GameDescriptionWorker: GameDescriptionWorkerLogic {}
