//
//  GameDescriptionFactory.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 29/07/2024.
//

import Foundation

typealias GameDescriptionFactory = GameDescriptionViewFactory

protocol GameDescriptionViewFactory {
    func makeGameDescriptionView(navigationPathHolder: NavigationPathHolder) -> GameDescriptionView<GameDescriptionPresenter>
}
