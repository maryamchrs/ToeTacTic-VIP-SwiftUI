//
//  PlayerPersonalSetupWorker.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 31/07/2024.
//

import Foundation

protocol PlayerPersonalSetupWorkerLogic {}

final class PlayerPersonalSetupWorker {
    // MARK: - Object lifecycle
    init() {
        CustomLogger.logInit(owner: String(describing: PlayerPersonalSetupWorker.self))
    }

    // MARK: - Deinit
    deinit {
        CustomLogger.logDeinit(owner: String(describing: PlayerPersonalSetupWorker.self))
    }

    // MARK: - Properties

    // MARK: Private
}

// MARK: - Methods

// MARK: Private
private extension PlayerPersonalSetupWorker {}

// MARK: - Worker Logic
extension PlayerPersonalSetupWorker: PlayerPersonalSetupWorkerLogic {}
