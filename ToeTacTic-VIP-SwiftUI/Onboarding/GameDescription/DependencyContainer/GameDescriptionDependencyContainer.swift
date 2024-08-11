//
//  GameDescriptionDependencyContainer.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 29/07/2024.
//

import Foundation
import SwiftUI

final class GameDescriptionDependencyContainer: DependencyContainer {
    // MARK: - Object lifecycle
    override init() {
        CustomLogger.logInit(owner: String(describing: GameDescriptionDependencyContainer.self))
    }
    
    // MARK: - Deinit
    deinit {
        CustomLogger.logDeinit(owner: String(describing: GameDescriptionDependencyContainer.self))
    }
    
    var interactor: GameDescriptionInteractor?
    var presenter: GameDescriptionPresenter?
}

// MARK: - Factory
extension GameDescriptionDependencyContainer: GameDescriptionFactory {
    @MainActor func makeGameDescriptionView(navigationPathHolder: NavigationPathHolder) -> GameDescriptionView<GameDescriptionPresenter> {
        let interactor = getInteractor()
        let worker = GameDescriptionWorker()
        interactor.worker = worker
        let presenter = getPresenter()
        interactor.presenter = presenter
        let router = GameDescriptionRouter()
        router.navigationPathHolder = navigationPathHolder
        let view = GameDescriptionView(interactor: interactor,
                                       presenter: presenter,
                                       router: router)
        return view
    }
}

// MARK: - Private Methods

private extension GameDescriptionDependencyContainer {
    func getInteractor() -> GameDescriptionInteractor {
        guard let interactor else {
            let interactor = GameDescriptionInteractor()
            self.interactor = interactor
            return interactor
        }
        return interactor
    }
    
    @MainActor func getPresenter() -> GameDescriptionPresenter {
        guard let presenter else {
            let presenter = GameDescriptionPresenter()
            self.presenter = presenter
            return presenter
        }
        return presenter
    }
}
