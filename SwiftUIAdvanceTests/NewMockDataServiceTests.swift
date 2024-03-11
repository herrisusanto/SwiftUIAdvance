//
//  NewMockDataServiceTests.swift
//  SwiftUIAdvanceTests
//
//  Created by loratech on 11/03/24.
//

import XCTest
@testable import SwiftUIAdvance
import Combine

final class NewMockDataServiceTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        cancellables.removeAll()
    }

    func test_NewMockDataService_init_doesSetValuesCorrectly() {
        // MARK:  Given
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString,UUID().uuidString,UUID().uuidString,UUID().uuidString,UUID().uuidString]
        // MARK:  When
        let service = NewMockDataService(items: items)
        let service2 = NewMockDataService(items: items2)
        let service3 = NewMockDataService(items: items3)
        // MARK:  Then
        XCTAssertFalse(service.items.isEmpty)
        XCTAssertTrue(service2.items.isEmpty)
        XCTAssertEqual(service3.items.count, items3?.count)

    }

    func test_NewMockDataService_downloadItemsWithEscaping_doesReturnValues() {
        // MARK:  Given
        let service = NewMockDataService(items: nil)
        // MARK:  When
        var items: [String] = []
        let expectation = XCTestExpectation()

        service.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        // MARK:  Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, service.items.count)
    }

    func test_NewMockDataService_downloadItemsWithCombine_doesReturnValues() {
        // MARK:  Given
        let service = NewMockDataService(items: nil)
        // MARK:  When
        var items: [String] = []
        let expectation = XCTestExpectation()

        service.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                    case.finished:
                        expectation.fulfill()
                    case.failure(let error):
                        XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems

            }
            .store(in: &cancellables)

        // MARK:  Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, service.items.count)
    }

    func test_NewMockDataService_downloadItemsWithCombine_doesFail() {
        // MARK:  Given
        let service = NewMockDataService(items: [])
        // MARK:  When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "Does throw and error!")
        let expectation2 = XCTestExpectation(description: "Does throw and URLError.badServerResponse!")

        service.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                    case.finished:
                        XCTFail()
                    case.failure(let error):
                        expectation.fulfill() 

                        if error  as? URLError == URLError(.badServerResponse) {
                            expectation2.fulfill()
                        }
                }
            } receiveValue: { returnedItems in
                items = returnedItems

            }
            .store(in: &cancellables)

        // MARK:  Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, service.items.count)
    }

}
