//
//  UnitTestingBootcampViewModelTests.swift
//  SwiftUIAdvanceTests
//
//  Created by loratech on 10/03/24.
//

import XCTest
@testable import SwiftUIAdvance
import Combine

// Naming Structure : test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure : test_[class or struct]_[variable or function]_[expected result]

// Testing Structure : Given, When, Then

final class UnitTestingBootcampViewModelTests: XCTestCase {
    
    var viewModel: UnitTestingBootcampViewModel?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        // When
        let viewModel = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertTrue(viewModel.isPremium)
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeFalse() {
        // Given
        let userIsPremium: Bool = false
        // When
        let viewModel = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertFalse(viewModel.isPremium)
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue() {
        // MARK:  Given
        let userIsPremium: Bool = Bool.random()
        // MARK:  When
        let viewModel = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        // MARK:  Then
        XCTAssertEqual(viewModel.isPremium, userIsPremium)
    }

    func test_UnitTestingBootcampViewModel_isPremium_ShouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            // MARK:  Given
            let userIsPremium: Bool = Bool.random()
            // MARK:  When
            let viewModel = UnitTestingBootcampViewModel(isPremium: userIsPremium)
            // MARK:  Then
            XCTAssertEqual(viewModel.isPremium, userIsPremium)
        }
    }

    func test_UnitTestingBootcampViewModel_dataArray_shouldBeEmpty() {
        // MARK:  Given

        // MARK:  When
        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
        // MARK:  Then
        XCTAssertTrue(viewModel.dataArray.isEmpty)
        XCTAssertEqual(viewModel.dataArray.count, 0)
    }

    func test_UnitTestingBootcampViewModel_dataArray_shouldAddItems() {
        // MARK:  Given
        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
        // MARK:  When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }
        // MARK:  Then
        XCTAssertTrue(!viewModel.dataArray.isEmpty)
        XCTAssertFalse(viewModel.dataArray.isEmpty)
        XCTAssertEqual(viewModel.dataArray.count, loopCount)
        XCTAssertNotEqual(viewModel.dataArray.count, 0)
        XCTAssertGreaterThan(viewModel.dataArray.count, 0)
    }

    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankString() {
        // MARK:  Given
        guard let viewModel = viewModel else {
            XCTFail()
            return
        }
        // MARK:  When
        viewModel.addItem(item: "")
        // MARK:  Then
        XCTAssertTrue(viewModel.dataArray.isEmpty)
    }

    func test_UnitTestingBootcampViewModel_selectedItem_shouldStartAsNil() {
        // MARK:  Given

        // MARK:  When
        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
        // MARK:  Then
        XCTAssertTrue(viewModel.selectedItem == nil)
        XCTAssertNil(viewModel.selectedItem)
    }

    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // MARK:  Given
        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
        // MARK:  When
        // MARK:  Select valid item
        let newItem = UUID().uuidString
        viewModel.addItem(item: newItem)
        viewModel.selectItem(item: newItem)

        // MARK:  Selecte invalid item
        viewModel.selectItem(item: UUID().uuidString)
        // MARK:  Then
        XCTAssertNil(viewModel.selectedItem)
    }

    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected() {
        // MARK:  Given
        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
        // MARK:  When
        let newItem = UUID().uuidString
        viewModel.addItem(item: newItem)
        viewModel.selectItem(item: newItem)
        // MARK:  Then
        XCTAssertNotNil(viewModel.selectedItem)
        XCTAssertEqual(viewModel.selectedItem, newItem)

    }

    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected_stress() {
        // MARK:  Given
        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
        // MARK:  When
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []

        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            viewModel.addItem(item: newItem)
            itemsArray.append(newItem)
        }

        let randomItem = itemsArray.randomElement() ?? ""
        viewModel.selectItem(item: randomItem)


        // MARK:  Then
        XCTAssertNotNil(viewModel.selectedItem)
        XCTAssertEqual(viewModel.selectedItem, randomItem)

    }

    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_itemNotFound() {
        // MARK:  Given
        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
        // MARK:  When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }

        // MARK:  Then
        do {
            try viewModel.saveItem(item: UUID().uuidString)
        } catch let error {
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.itemNotFound)
        }

    }

    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_noData() {
        // MARK:  Given
        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
        // MARK:  When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }

        // MARK:  Then
        do {
            try viewModel.saveItem(item: "")
        }catch let error {
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.noData)
        }
    }

    func test_UnitTestingBootcampViewModel_saveItem_shouldSaveItem() {
        // MARK:  Given
        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
        // MARK:  When
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []

        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            viewModel.addItem(item: newItem)
            itemsArray.append(newItem)
        }

        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)

        // MARK:  Then
        do {
            try viewModel.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }

    }

    func test_UnitTestingBootcampViewModel_downloadWithEscaping_shouldReturnItems() {
        // MARK:  Given
        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
        // MARK:  When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")

        viewModel.$dataArray
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }.store(in: &cancellables)

        viewModel.downloadWithEscaping()
        // MARK:  Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.dataArray.count, 0)
    }

    func test_UnitTestingBootcampViewModel_downloadWithCombine_shouldReturnItems() {
        // MARK:  Given
        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
        // MARK:  When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")

        viewModel.$dataArray
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }.store(in: &cancellables)

        viewModel.downloadWithCombine()
        // MARK:  Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.dataArray.count, 0)
    }

    func test_UnitTestingBootcampViewModel_downloadWithCombine_shouldReturnItems2() {
        // MARK:  Given
        let items: [String] = [UUID().uuidString,UUID().uuidString,UUID().uuidString,UUID().uuidString,UUID().uuidString]
        let dataService: NewDataServiceProtocol = NewMockDataService(items: items)

        let viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random(), service: dataService)
        // MARK:  When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")

        viewModel.$dataArray
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }.store(in: &cancellables)

        viewModel.downloadWithCombine()
        // MARK:  Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.dataArray.count, 0)
        XCTAssertEqual(viewModel.dataArray.count, items.count)
    }



}
