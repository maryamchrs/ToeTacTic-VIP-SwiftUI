//
//  MainPlaygroundView.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 12/11/2023.
//

import SwiftUI

struct MainPlaygroundView<Presenter: MainPlaygroundPresenter>: View {
    
    // MARK: - Properties and Constants
    var interactor: MainPlaygroundInteractor?
    @ObservedObject var presenter: Presenter
    var router: MainPlaygroundRoutingLogic?

    // MARK: Private Properties
    
    // MARK: - Body
    var body: some View {
        ZStack {
            PlaygroundBackground(opacity: 0.1)
            VStack {
                LogoAndTitleView()
                
                Spacer()
                
                messagesText
                
                board
                
                Spacer()
                
                CustomButton(text: "new_game".localized(),
                             imageName: "ForwardArrow",
                             imageSide: .right,
                             completionHandler: {
                    router?.routeBack()
                })
            }
            .padding(.top, Constants.topSpacing)
            .padding(.bottom, 16)
        }
        .onAppear {
            interactor?.viewWillAppear(request: MainPlayground.ViewWillAppear.Request())
        }
        .ignoresSafeArea(edges: [.horizontal])
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Private Methods and Properties
private extension MainPlaygroundView {
    var board: some View {
        VStack(spacing: 16) {
            ZStack {
                TicTacToeTableView()
                    .frame(width: 304, height: 304)
                BoxesView(interactor: interactor,
                          presenter: presenter)
                    .frame(width: 304, height: 304)
            }
        }
    }
    
    var messagesText: some View {
        VStack(spacing: 0) {
            Group {
                Text(presenter.viewModel.titleMessage)
                    .font(.sfPro(ofSize: 24,
                                 weight: .bold))
                    .isHidden(presenter.viewModel.titleMessage.isEmpty)
                Text(presenter.viewModel.message)
                    .font(.sfPro(ofSize: 16,
                                 weight: .regular))
                    .lineLimit(2)
                    .isHidden(presenter.viewModel.message.isEmpty)
            }
            .transition(.opacity)
            .foregroundStyle(getTheRightColorForTextMessage())
            .multilineTextAlignment(.center)
        }
        .frame(height: 48)
    }
    
    func getTheRightColorForTextMessage() -> Color {
        return presenter.viewModel.playerSelectedPiece.relatedMessageColor
    }
}
