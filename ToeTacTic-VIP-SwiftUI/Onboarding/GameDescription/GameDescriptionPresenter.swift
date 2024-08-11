//
//  GameDescriptionPresenter.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 29/07/2024.
//

import Foundation

@MainActor protocol GameDescriptionPresentationLogic: ObservableObject {
    var viewModel: GameDescription.ViewModel { get }
}

@MainActor final class GameDescriptionPresenter: GameDescriptionPresentationLogic {
    @Published private(set) var viewModel = GameDescription.ViewModel()
}

