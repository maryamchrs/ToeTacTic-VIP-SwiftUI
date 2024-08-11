//
//  ViewFactory.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 24/10/2023.
//

import SwiftUI

enum ViewFactory {
    
    @MainActor @ViewBuilder
    static func start(navigationPathHolder: NavigationPathHolder) -> some View {
        let dependencyContainer = GameDescriptionDependencyContainer()
        dependencyContainer.makeGameDescriptionView(navigationPathHolder: navigationPathHolder)
    }
    
    @MainActor @ViewBuilder
    static func makeGameDescriptionView(navigationPathHolder: NavigationPathHolder) -> some View {
        let dependencyContainer = GameDescriptionDependencyContainer()
        dependencyContainer.makeGameDescriptionView(navigationPathHolder: navigationPathHolder)
    }
    
    @MainActor @ViewBuilder
    static func createView(_ destination: Destination, navigationPathHolder: NavigationPathHolder) -> some View {
        switch destination {
        case .onboarding:
            makeGameDescriptionView(
                navigationPathHolder: navigationPathHolder
            )
        case .playground(let info):
            MainPlaygroundDependencyContainer().makeMainPlaygroundView(
                navigationPathHolder: navigationPathHolder,
                playerNickName: info.name,
                playerSelectedPiece: info.selectedOption
            )
        case .personalSetup:
            PlayerPersonalSetupDependencyContainer()
                .makePlayerPersonalSetupView(
                    navigationPathHolder: navigationPathHolder
                )
        }
    }
}
