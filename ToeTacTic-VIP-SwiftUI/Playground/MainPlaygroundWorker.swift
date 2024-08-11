//
//  MainPlaygroundWorker.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 02/08/2024.
//

import Foundation

protocol MainPlaygroundWorkerLogic {}

final class MainPlaygroundWorker {
    // MARK: - Object lifecycle
    init() {
        CustomLogger.logInit(owner: String(describing: MainPlaygroundWorker.self))
    }

    // MARK: - Deinit
    deinit {
        CustomLogger.logDeinit(owner: String(describing: MainPlaygroundWorker.self))
    }

    // MARK: - Properties

    // MARK: Private
}

// MARK: - Methods

// MARK: Private
private extension MainPlaygroundWorker {}

// MARK: - Worker Logic
extension MainPlaygroundWorker: MainPlaygroundWorkerLogic {}
