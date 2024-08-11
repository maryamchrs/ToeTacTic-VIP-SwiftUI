//
//  MainPlaygroundFactory.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 02/08/2024.
//

import Foundation

typealias MainPlaygroundFactory = MainPlaygroundViewFactory

protocol MainPlaygroundViewFactory {
    func makeMainPlaygroundView(navigationPathHolder: NavigationPathHolder,
                                playerNickName: String,
                                playerSelectedPiece: GamePiece) -> MainPlaygroundView<MainPlaygroundPresenter>
}
