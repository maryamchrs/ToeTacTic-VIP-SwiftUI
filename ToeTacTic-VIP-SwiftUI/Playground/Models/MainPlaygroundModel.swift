//
//  MainPlaygroundModel.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 02/08/2024.
//

import Foundation
import SwiftUI

enum MainPlayground {
    
    struct ViewModel {
        var titleMessage: String = ""
        var message: String = ""
        var isBoardEnable: Bool = true
        var boxesInfo: [BoxInfo] = BoxInfo.initialStates
        var playerSelectedPiece: GamePiece = .oPiece
        var currentPlayer: Player = .user
    }
    
    enum ViewDidLoad {
        struct Request {
        }
        struct Response {
        }
    }
    
    enum ViewWillAppear {
        struct Request {
        }
        struct Response {
            let userGamePiece: GamePiece
        }
    }
    
    enum OneBoxSelected {
        struct Request {
            let index: Int
        }
        struct Response {
            let index: Int
        }
    }
    
    enum ShowMessage {
        struct Request {
        }
        struct Response {
            let message: String
        }
    }
    
    enum ShowTitle {
        struct Request {
        }
        struct Response {
            let tile: String
        }
    }
    
    enum ChangeCurrentPlayer {
        struct Request {
        }
        struct Response {
            let player: Player
        }
    }
    
    enum BoxesInfo {
        struct Request {
        }
        struct Response {
            let boxes: [BoxInfo]
        }
    }
    
    enum BoardEnableStatus {
        struct Request {
        }
        struct Response {
            let shouldBeEnabled: Bool
        }
    }
}
