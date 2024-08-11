//
//  PlayerPersonalSetupDependencyContainer.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 31/07/2024.
//

import Foundation

final class PlayerPersonalSetupDependencyContainer: DependencyContainer {
    // MARK: - Object lifecycle
    override init() {
        CustomLogger.logInit(owner: String(describing: PlayerPersonalSetupDependencyContainer.self))
    }
    
    // MARK: - Deinit
    deinit {
        CustomLogger.logDeinit(owner: String(describing: PlayerPersonalSetupDependencyContainer.self))
    }
    
    var interactor: PlayerPersonalSetupInteractor?
    var presenter: PlayerPersonalSetupPresenter?
}

// MARK: - Factory
extension PlayerPersonalSetupDependencyContainer: PlayerPersonalSetupFactory {
    @MainActor func makePlayerPersonalSetupView(navigationPathHolder: NavigationPathHolder) -> PlayerPersonalSetupView<PlayerPersonalSetupPresenter> {
        let interactor = getInteractor()
        let worker = PlayerPersonalSetupWorker()
        interactor.worker = worker
        let presenter = getPresenter()
        interactor.presenter = presenter
        let router = PlayerPersonalSetupRouter()
        router.navigationPathHolder = navigationPathHolder
        let view = PlayerPersonalSetupView(interactor: interactor,
                                       presenter: presenter,
                                       router: router)
        return view
    }
}

//MARK: - Private methods

private extension PlayerPersonalSetupDependencyContainer {
    func getInteractor() -> PlayerPersonalSetupInteractor {
        guard let interactor else {
            let interactor = PlayerPersonalSetupInteractor()
            self.interactor = interactor
            return interactor
        }
        return interactor
    }
    
    @MainActor func getPresenter() -> PlayerPersonalSetupPresenter {
        guard let presenter else {
            let presenter = PlayerPersonalSetupPresenter()
            self.presenter = presenter
            return presenter
        }
        return presenter
    }
}
