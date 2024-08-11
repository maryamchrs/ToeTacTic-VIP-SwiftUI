//
//  DependencyContainer.swift
//  ToeTacTic-VIP-SwiftUI
//
//  Created by Maryam Chrs on 30/07/2024.
//

import Foundation

protocol DependencyContainerProtocol {
    func getStorageManager() -> StorageManager
}

class DependencyContainer {
    private lazy var storageManager: StorageManager = UserDefaultsBasedStorageManager()
}

extension DependencyContainer {
    func getStorageManager() -> StorageManager {
        storageManager
    }
}
