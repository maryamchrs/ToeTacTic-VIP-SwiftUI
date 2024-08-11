//
//  BoxesView.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 12/11/2023.
//

import SwiftUI

struct BoxesView<Presenter: MainPlaygroundPresenter>: View {
    
    var interactor: MainPlaygroundInteractor?
    @ObservedObject var presenter: Presenter
    
    // MARK: - Private Properties
    let horizontalSpace: CGFloat = 38
    let verticalSpace: CGFloat = 39
    var foregroundStyleColor: Color = .lightBackgroundGray
    
    // MARK: - View
    var body: some View {
        VStack(spacing: verticalSpace) {
            Group {
                makeHorizontalBoxes(Array(presenter.viewModel.boxesInfo.prefix(3)))
                makeHorizontalBoxes(Array(presenter.viewModel.boxesInfo[3...5]))
                makeHorizontalBoxes(Array(presenter.viewModel.boxesInfo[6...8]))
            }
        }
    }
}
 
private extension BoxesView {
    
    @ViewBuilder
    func makeVerticalRectangles(_ buttonIdentifiers: [Int]) -> some View {
        VStack(spacing: verticalSpace) {
            ForEach(buttonIdentifiers, id: \.self) { buttonIdentifier in
                Button {
                    
                } label: {
                    XIconView()
                        .foregroundStyle(foregroundStyleColor)
                        .frame(width: 64, height: 64, alignment: .center)
                }
                .tag(buttonIdentifier)
            }
        }
    }
    
    @ViewBuilder
    func makeHorizontalBoxes(_ boxesInfo: [BoxInfo]) -> some View {
        HStack(spacing: horizontalSpace) {
            ForEach(boxesInfo, id: \.id) { boxInfo in
                makeBox(boxInfo: boxInfo)
                    .disabled(presenter.viewModel.isBoardEnable ? false : true)
            }
        }
    }
    
    @ViewBuilder
    func makeBox(boxInfo: BoxInfo) -> some View {
        Button {
            let request = MainPlayground.OneBoxSelected.Request(index: boxInfo.id)
            interactor?.oneBoxIsSelected(request: request)
        } label: {
            if boxInfo.status == .xPiece {
                XIconView()
                    .foregroundStyle(foregroundStyleColor)
                    .frame(width: 64, height: 64, alignment: .center)
            } else if boxInfo.status == .oPiece {
                OIconView()
                    .foregroundStyle(foregroundStyleColor)
                    .frame(width: 64, height: 64, alignment: .center)
            } else {
                EmptyBoxView()
                    .frame(width: 64, height: 64, alignment: .center)
            }
        }
        .tag(boxInfo.id)
    }
}

//#Preview {
//    BoxesView(viewModel: MainPlaygroundViewModel(playerNickName: "", playerSelectedPiece: .oPiece))
//}
