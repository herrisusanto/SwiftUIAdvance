//
//  UnitTestingBootcampViewModel.swift
//  SwiftUIAdvance
//
//  Created by loratech on 10/03/24.
//

import Foundation
import SwiftUI
import Combine



class UnitTestingBootcampViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    var cancellables = Set<AnyCancellable>()

    let service: NewDataServiceProtocol

    init(isPremium: Bool, service: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.service = service
    }

    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }

    func selectItem(item: String) {
        if let firstItem = dataArray.first(where: {$0 == item}){
            selectedItem = firstItem
        } else {
            selectedItem = nil
        }
    }

    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }

        if let firstItem = dataArray.first(where: {$0 == item}){
            print("Save item here: \(firstItem)")
        } else {
            throw DataError.itemNotFound
        }
    }

    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }

    func downloadWithEscaping() {
        service.downloadItemsWithEscaping { [weak self] items in
            self?.dataArray = items
        }
    }

    func downloadWithCombine() {
        service.downloadItemsWithCombine()
            .sink { _ in

            } receiveValue: { [weak self] items in
                self?.dataArray = items
            }
            .store(in: &cancellables)

    }
}

