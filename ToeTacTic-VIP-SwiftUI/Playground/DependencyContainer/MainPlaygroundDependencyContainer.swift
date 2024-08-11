//
//  MainPlaygroundDependencyContainer.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 02/08/2024.
//

import Foundation

final class MainPlaygroundDependencyContainer: DependencyContainer {
    // MARK: - Object lifecycle
    override init() {
        CustomLogger.logInit(owner: String(describing: MainPlaygroundDependencyContainer.self))
    }
    
    // MARK: - Deinit
    deinit {
        CustomLogger.logDeinit(owner: String(describing: MainPlaygroundDependencyContainer.self))
    }
    
    var interactor: MainPlaygroundInteractor?
    var presenter: MainPlaygroundPresenter?
}

// MARK: - Factory
extension MainPlaygroundDependencyContainer: MainPlaygroundFactory {
    @MainActor func makeMainPlaygroundView(
        navigationPathHolder: NavigationPathHolder,
        playerNickName: String,
        playerSelectedPiece: GamePiece
    ) -> MainPlaygroundView<MainPlaygroundPresenter> {
        let interactor = getInteractor()
        let worker = MainPlaygroundWorker()
        interactor.worker = worker
        interactor.playerNickName = playerNickName
        interactor.playerSelectedPiece = playerSelectedPiece
        let presenter = getPresenter()
        interactor.presenter = presenter
        let router = MainPlaygroundRouter()
        router.dataStore = interactor
        router.navigationPathHolder = navigationPathHolder
        let view = MainPlaygroundView(interactor: interactor,
                                       presenter: presenter,
                                       router: router)
        return view
    }
}

extension MainPlaygroundDependencyContainer {
    func getInteractor() -> MainPlaygroundInteractor {
        guard let interactor else {
            let interactor = MainPlaygroundInteractor()
            self.interactor = interactor
            return interactor
        }
        return interactor
    }
    
    @MainActor func getPresenter() -> MainPlaygroundPresenter {
        guard let presenter else {
            let presenter = MainPlaygroundPresenter()
            self.presenter = presenter
            return presenter
        }
        return presenter
    }
}
