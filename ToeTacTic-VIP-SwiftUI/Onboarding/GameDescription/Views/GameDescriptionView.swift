//
//  GameDescriptionView.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 24/10/2023.
//

import SwiftUI
import Combine

struct GameDescriptionView<Presenter: GameDescriptionPresentationLogic>: View {
    
    // MARK: - Properties and Constants
    var interactor: GameDescriptionInteractor?
    @ObservedObject var presenter: Presenter
    var router: GameDescriptionRoutingLogic?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            PlaygroundBackground()
            VStack {
                GameDescriptionMainPartView {
                    router?.routeToPlayerPersonalSetupView()
                }
                Spacer()
            }
            .padding(.top, Constants.topSpacing)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Private methods
private extension GameDescriptionView {}

// MARK: - PreviewProvider
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        GameDescriptionView(interactor: GameDescriptionInteractor(),
                            presenter: GameDescriptionPresenter())
    }
}
