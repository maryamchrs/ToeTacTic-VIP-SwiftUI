//
//  MainPlaygroundInteractor.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 02/08/2024.
//

import Foundation

protocol MainPlaygroundBusinessLogic {
    func oneBoxIsSelected(request: MainPlayground.OneBoxSelected.Request)
    func viewWillAppear(request: MainPlayground.ViewWillAppear.Request)
}

protocol MainPlaygroundDataStore {
    var playerNickName: String! { get set }
    var playerSelectedPiece: GamePiece! { get set }
}

final class MainPlaygroundInteractor: MainPlaygroundDataStore {
    // MARK: - Object lifecycle
    init() {
        CustomLogger.logInit(owner: String(describing: MainPlaygroundInteractor.self))
    }
    
    // MARK: - Deinit
    deinit {
        CustomLogger.logDeinit(owner: String(describing: MainPlaygroundInteractor.self))
    }
    
    enum Message {
        case alreadyExists
        case someoneLost
        case someoneWon
        case gameFinished
        case waiting(playerNickName: String, piece: String)
        case noOneWonTheGame
        
        var description: String {
            switch self {
            case .alreadyExists:
                "this_bos_is_already_selected".localized()
            case .someoneLost:
                "losing_message_description".localized()
            case .someoneWon:
                "wining_message_description".localized()
            case .gameFinished:
                "tied_game_message".localized()
            case .waiting(let playerNickName, let piece):
                "waiting_message".localized(withArgs: [playerNickName, piece])
            case .noOneWonTheGame:
                "tied_game_message".localized()
            }
        }
    }
    
    // MARK: - Properties
    // MARK: Private
    private var message: String = "" {
        didSet {
            Task {
                let response = MainPlayground.ShowMessage.Response(message: message)
                await presenter?.updateMessage(response: response)
            }
        }
    }
    
    private var currentPlayer: Player = .user {
        didSet {
            Task {
                let response = MainPlayground.ChangeCurrentPlayer.Response(player: currentPlayer)
                await presenter?.updateCurrentPlayer(response: response)
            }
        }
    }
    
    private var titleMessage: String = "" {
        didSet {
            Task {
                let response = MainPlayground.ShowTitle.Response(tile: titleMessage)
                await presenter?.updateTitle(response: response)
            }
        }
    }
    
    private var isBoardEnable: Bool = true {
        didSet {
            Task {
                let response = MainPlayground.BoardEnableStatus.Response(shouldBeEnabled: isBoardEnable)
                await presenter?.updateBoardEnableStatus(response: response)
            }
        }
    }
    
    private var boxesInfo: [BoxInfo] = BoxInfo.initialStates
    private let winningStates = Constants.winingStates
    private var userMoves: [Int] = []
    private var userOpponentMoves: [Int] = []
    private var isGameFinished: Bool = false
    
    // MARK: Public
    var presenter: MainPlaygroundPresenter?
    var worker: MainPlaygroundWorkerLogic?
    var playerNickName: String!
    var playerSelectedPiece: GamePiece!
}

//MARK: - MainPlaygroundBusinessLogic
extension MainPlaygroundInteractor: MainPlaygroundBusinessLogic {
    func viewWillAppear(request: MainPlayground.ViewWillAppear.Request) {
        Task {
            message = Message.waiting(playerNickName: playerNickName,
                                      piece: playerSelectedPiece.rawValue).description
            let response = MainPlayground.ViewWillAppear.Response(userGamePiece: playerSelectedPiece)
            await presenter?.updateUserGamePiece(response: response)
        }
    }
    
    func oneBoxIsSelected(request: MainPlayground.OneBoxSelected.Request) {
        Task {
            let index = request.index
            
            clearMessages()
            guard !isTheGameEnded() else { return }
            
            if isMoveAlreadyExists(atIndex: index) {
                message = Message.alreadyExists.description
                return
            }
            
            addMove(for: .user, index: index)
            
            let (isSomeoneLostTheGame, lossMessageTitle, lossMessageDescription) = checkIfSomeoneLostTheGame(currentPlayer: currentPlayer)
            if isSomeoneLostTheGame {
                titleMessage = lossMessageTitle
                message = lossMessageDescription
                finisheTheGame()
                return
            }
            
            if checkForFinishingTheGame() {
                message = Message.gameFinished.description
                finisheTheGame()
                return
            }
            
            changeCurrentPlayer()
            await makeMoveForBot()
        }
    }
}

//MARK: - Private Methods
private extension MainPlaygroundInteractor {
    
    func makeMoveForBot() async {
        guard !isTheGameEnded() else { return }
        updateBoardEnablingStatus(false)
        let (safeMoves, possibleMoves) = availableMoves()
        try? await Task.sleep(nanoseconds: Constants.delayOfThinkingInNanoseconds)
        
        let botIndex: Int = !safeMoves.isEmpty ? (safeMoves.randomElement()!) : (possibleMoves.randomElement()!)
        addMove(for: .userOpponent, index: botIndex)
        
        let (isSomeoneLostTheGame, losingTitleMessage, losingDescriptionMessage) = checkIfSomeoneLostTheGame(currentPlayer: currentPlayer)
        if isSomeoneLostTheGame {
            titleMessage = losingTitleMessage
            message = losingDescriptionMessage
            return
        }
        
        if checkForFinishingTheGame() {
            message = Message.gameFinished.description
            return
        }
        
        changeCurrentPlayer()
        updateBoardEnablingStatus(true)
        message = Message.waiting(playerNickName: playerNickName,
                                  piece: playerSelectedPiece.rawValue).description
    }
    
    func clearMessages() {
        titleMessage = ""
        message = ""
    }
    
    func isTheGameEnded() -> Bool {
        isGameFinished
    }
    
    func addMove(for player: Player, index: Int) {
        switch player {
        case .user:
            // User
            userMoves.append(index)
            createBoxInfo(index: index)
        case .userOpponent:
            // Bot
            createBoxInfo(index: index)
            userOpponentMoves.append(index)
        }
    }
    
    func finisheTheGame() {
        isGameFinished = true
        updateBoardEnablingStatus(false)
    }
    
    func updateBoardEnablingStatus(_ status: Bool) {
        isBoardEnable = status
    }
    
    func isMoveAlreadyExists(atIndex moveIndex: Int) -> Bool {
        return userMoves.contains(where: { $0 == moveIndex }) || userOpponentMoves.contains(where: { $0 == moveIndex })
    }
    
    func checkIfSomeoneLostTheGame(currentPlayer: Player) -> (isLostStatus: Bool, title: String, message: String) {
        let moves: [Int]
        let titleMessage: String
        let message: String
        switch currentPlayer {
        case .user:
            moves = userMoves
            titleMessage = "losing_message_title".localized(withArgs: [playerNickName])
            message = Message.someoneLost.description
        case .userOpponent:
            moves = userOpponentMoves
            titleMessage = "wining_message_title".localized(withArgs: [playerNickName])
            message = Message.someoneWon.description
        }
        return (checkForBecomingLostStatus(moves: moves), titleMessage, message)
    }
    
    func checkForBecomingLostStatus(moves: [Int]) -> Bool {
        for combination in winningStates {
            let intersection = Set(combination).intersection(moves)
            if intersection.count == 3 {
                return true
            }
        }
        return false
    }
    
    func changeCurrentPlayer() {
        switch currentPlayer {
        case .user:
            currentPlayer = .userOpponent
        case .userOpponent:
            currentPlayer = .user
        }
    }
    
    func createBoxInfo(index: Int) {
        Task {
            guard let indexToUpdate = boxesInfo.firstIndex(where: { $0.id == index }) else { return }
            
            boxesInfo[indexToUpdate] = BoxInfo(id: index, status: findRelatedStatusForBox())
            await presenter?.updateBoxesInfo(response: MainPlayground.BoxesInfo.Response(boxes: boxesInfo))
        }
    }
    
    func findRelatedStatusForBox() -> GamePiece {
        switch currentPlayer {
        case .user:
            return playerSelectedPiece
        case .userOpponent:
            return playerSelectedPiece.opponentChoice
        }
    }
    
    func findOptionsWithProbabilityOfWinning(moves: [Int]) -> [Int] {
        var options: [[Int]] = []
        for combination in Constants.winingStates {
            let intersection = Set(combination).intersection(moves)
            if intersection.count == 2 {
                // If two moves are already made in this combination, add it to successful options
                options.append(Array(Set(combination).subtracting(intersection)))
            }
        }
        
        return options.flatMap({$0})
    }
    
    func availableMoves() -> ([Int], [Int]) {
        let moves: [Int] = (0..<9).map { $0 }
            .removingCommonElements(with: userMoves)
            .removingCommonElements(with: userOpponentMoves)
        let movesToLeadUserSuccess = findOptionsWithProbabilityOfWinning(moves: userMoves)
        let movesToLeadBotSuccess = findOptionsWithProbabilityOfWinning(moves: userOpponentMoves)
        let wholeSuccessfulMoves = Array(Set(movesToLeadUserSuccess + movesToLeadBotSuccess))
        let safeMoves = moves.filter { !wholeSuccessfulMoves.contains($0) }
        return (safeMoves, moves)
    }
    
    func checkForFinishingTheGame() -> Bool {
        let wholeMoves = Set(userMoves + userOpponentMoves)
        return wholeMoves.count == 9
    }
}
