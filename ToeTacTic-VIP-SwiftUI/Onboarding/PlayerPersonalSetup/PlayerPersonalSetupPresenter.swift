//
//  PlayerPersonalSetupPresenter.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 31/07/2024.
//

import Foundation

@MainActor protocol PlayerPersonalSetupPresentationLogic: ObservableObject {
    var viewModel: PlayerPersonalSetup.ViewModel { get }
}

@MainActor final class PlayerPersonalSetupPresenter: PlayerPersonalSetupPresentationLogic {
    
    @Published private(set) var viewModel = PlayerPersonalSetup.ViewModel()
    
    func updatePlayerName(response: PlayerPersonalSetup.PlayerNameChanged.Response) {
        viewModel.playerName = response.playerName
    }
    
    func changeSelectedPiece(response: PlayerPersonalSetup.OneOptionSelected.Response) {
        viewModel.selectedOption = response.option
    }
    
    func updateStartButtonEnableStatus(response: PlayerPersonalSetup.StartGameEnableStatus.Response) {
        viewModel.isStartButtonEnable = response.shouldBeEnabled
    }
    
    func presentPlaygroundView(response: PlayerPersonalSetup.PlaygroundScene.Response) {
        viewModel.playgroundMustBeShown = true
    }
}

