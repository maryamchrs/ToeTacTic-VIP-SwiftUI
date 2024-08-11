//
//  PlayerPersonalSetupView.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 12/11/2023.
//

import SwiftUI

struct PlayerPersonalSetupView<Presenter: PlayerPersonalSetupPresenter>: View {
    
    // MARK: - Properties and Constants
    var interactor: PlayerPersonalSetupInteractor?
    @ObservedObject var presenter: Presenter
    var router: PlayerPersonalSetupRoutingLogic?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            PlaygroundBackground()
            VStack {
                PlayerPersonalSetupMainPartView(interactor: interactor,
                                                presenter: presenter)
                Spacer()
            }
            .padding(.top, Constants.topSpacing)
            .padding(.horizontal, 32)
        }
        
        .onChange(of: presenter.viewModel.playgroundMustBeShown) { oldVlaue, newValue in
            guard let playerInfoModel = presenter.viewModel.playerInfoModel else { return }
            router?.routeToPlayground(info: playerInfoModel)
        }
        
        .toolbar(.hidden, for: .navigationBar)
    }
}
