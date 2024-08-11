//
//  PlayerPersonalSetupFactory.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 31/07/2024.
//

import Foundation

typealias PlayerPersonalSetupFactory = PlayerPersonalSetupViewFactory

protocol PlayerPersonalSetupViewFactory {
    func makePlayerPersonalSetupView(navigationPathHolder: NavigationPathHolder) -> PlayerPersonalSetupView<PlayerPersonalSetupPresenter>
}
