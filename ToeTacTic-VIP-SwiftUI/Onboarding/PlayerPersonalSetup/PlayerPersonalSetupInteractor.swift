//
//  PlayerPersonalSetupInteractor.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 31/07/2024.
//

import Foundation

protocol PlayerPersonalSetupBusinessLogic {
    func viewWillAppear(request: PlayerPersonalSetup.ViewWillAppear.Request)
    func playerNameIsChaneged(request: PlayerPersonalSetup.PlayerNameChanged.Request)
    func oneOptionIsChosen(request: PlayerPersonalSetup.OneOptionSelected.Request)
    func startGameButtonIsTapped(request: PlayerPersonalSetup.StartGameTapped.Request)
}

protocol PlayerPersonalSetupDataStore {}

final class PlayerPersonalSetupInteractor: PlayerPersonalSetupDataStore {
    
    // MARK: - Object lifecycle
    init() {
        CustomLogger.logInit(owner: String(describing: PlayerPersonalSetupInteractor.self))
    }

    // MARK: - Deinit
    deinit {
        viewWillAppearTask?.cancel()
        playerNameChangesTask?.cancel()
        optionChangesTask?.cancel()
        startGameTask?.cancel()
        CustomLogger.logDeinit(owner: String(describing: PlayerPersonalSetupInteractor.self))
    }

    // MARK: - Properties
    // MARK: Private
    private var selectedPiece: GamePiece?
    private var playerName: String = ""
   
    private(set) var viewWillAppearTask: Task<(), Never>?
    private(set) var playerNameChangesTask: Task<(), Never>?
    private(set) var optionChangesTask: Task<(), Never>?
    private(set) var startGameTask: Task<(), Never>?
    
    // MARK: Public
    var presenter: PlayerPersonalSetupPresenter?
    var worker: PlayerPersonalSetupWorkerLogic?
}

//MARK: - PlayerPersonalSetupBusinessLogic
extension PlayerPersonalSetupInteractor: PlayerPersonalSetupBusinessLogic {
    
    func viewWillAppear(request: PlayerPersonalSetup.ViewWillAppear.Request) {
        viewWillAppearTask?.cancel()
        viewWillAppearTask = Task {
            playerName = request.playerName
            await updateMainButtonStatus()
        }
    }
    
    func playerNameIsChaneged(request: PlayerPersonalSetup.PlayerNameChanged.Request) {
        playerNameChangesTask?.cancel()
        playerNameChangesTask = Task {
            playerName = request.playerName
            let response = PlayerPersonalSetup.PlayerNameChanged.Response(playerName: playerName)
            await presenter?.updatePlayerName(response: response)
            await updateMainButtonStatus()
        }
    }
    
    func oneOptionIsChosen(request: PlayerPersonalSetup.OneOptionSelected.Request) {
        optionChangesTask?.cancel()
        optionChangesTask = Task {
            selectedPiece = request.option
            let response = PlayerPersonalSetup.OneOptionSelected.Response(option: request.option)
            await presenter?.changeSelectedPiece(response: response)
            await updateMainButtonStatus()
        }
    }
    
    func startGameButtonIsTapped(request: PlayerPersonalSetup.StartGameTapped.Request) {
        startGameTask?.cancel()
        startGameTask = Task {
            await presenter?.presentPlaygroundView(response: PlayerPersonalSetup.PlaygroundScene.Response())
        }
    }
}

//MARK: - Private Methods
private extension PlayerPersonalSetupInteractor {
    func updateMainButtonStatus() async {
        await presenter?.updateStartButtonEnableStatus(
            response: PlayerPersonalSetup.StartGameEnableStatus.Response(
                shouldBeEnabled: !playerName.isEmpty && selectedPiece != nil
            )
        )
    }
}
