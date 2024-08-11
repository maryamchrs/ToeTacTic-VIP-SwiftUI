//
//  PlayerPersonalSetupMainPartView.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 12/11/2023.
//

import SwiftUI

struct PlayerPersonalSetupMainPartView<Presenter: PlayerPersonalSetupPresenter>: View {
    
    // MARK: - Properties and Constants
    var interactor: PlayerPersonalSetupInteractor?
    @ObservedObject var presenter: Presenter
    
    private let lightTertiary: Color = Color.tertiary.opacity(0.3)
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            LogoAndTitleView()
            Spacer()
                .frame(height: 80 - 16)
            Text("player_personal_setup_description".localized())
                .multilineTextAlignment(.leading)
                .font(.sfPro(ofSize: 16))
                .frame(width: 300, alignment: .topLeading)
                .lineSpacing(6)
                .padding(.bottom, 12)
            
            nickNameTextFeild
            
            optionView
                .padding(.bottom, 52)
            
            CustomButton(text: "start_the_game".localized(),
                         imageName: "ForwardArrow",
                         imageSide: .right,
                         completionHandler: {
                interactor?.startGameButtonIsTapped(request: PlayerPersonalSetup.StartGameTapped.Request())
            })
            .opacity(presenter.viewModel.isStartButtonEnable ? 1 : 0.3)
            .disabled(presenter.viewModel.isStartButtonEnable ? false : true)
        }
        .foregroundColor(.black)
        .ignoresSafeArea()
    }
}

// MARK: Private
private extension PlayerPersonalSetupMainPartView {
    var optionView: some View {
        HStack(spacing: 12) {
            LetterOptionButton(
                text: .xPiece,
                isChosen: presenter.viewModel.playerInfoModel?.selectedOption == .xPiece
            ) { char in
                interactor?.oneOptionIsChosen(request: PlayerPersonalSetup.OneOptionSelected.Request(option: .xPiece))
            }
            .frame(width: 32)
            Text("OR")
                .font(Font.sfPro(ofSize: 12))
            LetterOptionButton(
                text: .oPiece,
                isChosen: presenter.viewModel.playerInfoModel?.selectedOption == .oPiece
            ) { char in
                interactor?.oneOptionIsChosen(request: PlayerPersonalSetup.OneOptionSelected.Request(option: .oPiece))
            }
            .frame(width: 32)
        }
    }
    
    var nickNameTextFeild: some View {
        let playerNameBinding = Binding(
            get: { return presenter.viewModel.playerName },
            set: { newValue in
                interactor?.playerNameIsChaneged(request: PlayerPersonalSetup.PlayerNameChanged.Request(playerName: newValue))
            }
        )
        
        return TextField("nickname".localized(), text: playerNameBinding)
            .disableAutocorrection(true)
            .padding(.leading, 16)
            .frame(width: 300, height: 38)
            .tint(lightTertiary)
            .font(.sfPro(ofSize: 16))
            .foregroundColor(.black)
            .background(Color.lightSecondary)
            .cornerRadius(8)
            .padding(.bottom, 12)
//            .onChange(of: playerNameBinding) { oldValue, newValue in
//                interactor?.playerNameIsChaneged(newValue)
//            }
    }
}

// MARK: - Preview
//#Preview {
//    PlayerPersonalSetupMainPartView(viewModel: PlayerPersonalSetupViewModel())
//}
