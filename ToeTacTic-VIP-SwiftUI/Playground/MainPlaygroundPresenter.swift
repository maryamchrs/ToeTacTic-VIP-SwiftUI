//
//  MainPlaygroundPresenter.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 02/08/2024.
//

import Foundation

@MainActor protocol MainPlaygroundPresentationLogic: ObservableObject {
    var viewModel: MainPlayground.ViewModel { get }
}

@MainActor final class MainPlaygroundPresenter: MainPlaygroundPresentationLogic {
    @Published private(set) var viewModel = MainPlayground.ViewModel()
    
    func updateUserGamePiece(response: MainPlayground.ViewWillAppear.Response) {
        viewModel.playerSelectedPiece = response.userGamePiece
    }
    
    func updateMessage(response: MainPlayground.ShowMessage.Response) {
        viewModel.message = response.message
    }
    
    func updateTitle(response: MainPlayground.ShowTitle.Response) {
        viewModel.titleMessage = response.tile
    }
    
    func updateCurrentPlayer(response: MainPlayground.ChangeCurrentPlayer.Response) {
        viewModel.currentPlayer = response.player
    }
    
    func updateBoxesInfo(response: MainPlayground.BoxesInfo.Response) {
        viewModel.boxesInfo = response.boxes
    }
    
    func updateBoardEnableStatus(response: MainPlayground.BoardEnableStatus.Response) {
        viewModel.isBoardEnable = response.shouldBeEnabled
    }
}
