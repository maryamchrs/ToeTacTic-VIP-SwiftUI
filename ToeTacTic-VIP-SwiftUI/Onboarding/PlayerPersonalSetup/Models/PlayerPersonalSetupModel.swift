//
//  PlayerPersonalSetupModel.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 31/07/2024.
//

import Foundation

enum PlayerPersonalSetup {
    
    struct ViewModel {
        var playerName: String = ""
        var selectedOption: GamePiece?
        var isStartButtonEnable: Bool  = false
        var playgroundMustBeShown: Bool = false 
        
        var playerInfoModel: PlayerInfoModel? {
            guard let selectedOption else { return nil }
            return .init(name: playerName, selectedOption: selectedOption)
        }
    }

    enum ViewDidLoad {
        struct Request {
        }
        struct Response {
        }
    }
    
    enum ViewWillAppear {
        struct Request {
            let playerName: String
        }
        struct Response {
        }
    }
    
    enum PlayerNameChanged {
        struct Request {
            let playerName: String
        }
        struct Response {
            let playerName: String
        }
    }
    
    enum OneOptionSelected {
        struct Request {
            let option: GamePiece
        }
        struct Response {
            let option: GamePiece
        }
    }
    
    enum StartGameEnableStatus {
        struct Request {
            let shouldBeEnabled: Bool
        }
        struct Response {
            let shouldBeEnabled: Bool
        }
    }
    
    enum StartGameTapped {
        struct Request {
        }
        struct Response {
        }
    }
    
    enum PlaygroundScene {
        struct Request {
        }
        struct Response {
        }
    }
}
