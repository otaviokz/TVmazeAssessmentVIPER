//
//  SearchShowsInteractorTests.swift
//  TVMazeAssessmentVIPERTests
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import XCTest
@testable import TVMazeAssessmentVIPER

final class SearchShowsInteractorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchPagedShows_HappyPth() throws {
        // GIVEN
        let (sut, mockDataProvider) = makeSUT()
        
        // THEN
        XCTAssertEqual(sut.shows, [])
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.showErrorMessage, false)
        XCTAssertEqual(sut.errorMessage, "")
        
        // GIVEN
        mockDataProvider.shows = []
        
        _ = blockExpectation {
            // THEN it sets isLoading to true while waiting for
            sut.isLoading == true &&
            sut.shows == []
        }
        
        _ = blockExpectation {
            // THEN stops loading and receives a list of shows
            sut.isLoading == false
            && sut.shows == JSONLoader.showSearchSamplePage0()
        }
        
        // WHEN
        sut.searchText = "The"
        // Simulates async call that runs asynchronously and successfuly returns a shows array
        mockDataProvider.executeAfterSleep(extraTime: 1) {
            mockDataProvider.shows = JSONLoader.showSearchSamplePage0()
        }
        
        // THEN
        waitForExpectations(timeout: 10)
    }
    
    func testFetchPagedShows_ExceptionThrown() throws {
        // GIVEN
        let (sut, mockDataProvider) = makeSUT()
        
        // THEN
        XCTAssertEqual(sut.shows, [])
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.showErrorMessage, false)
        XCTAssertEqual(sut.errorMessage, "")
        
        // GIVEN
        _ = blockExpectation {
            sut.shows == [] &&
            sut.isLoading == true
        }
        
        _ = blockExpectation {
            // THEN sut should show error messages
            sut.isLoading == false &&
            sut.shows == [] &&
            sut.showErrorMessage == true &&
            sut.errorMessage == "Unable to search for '\(sut.searchText.searchSanitised)', please try again later."
        }
        
        // WHEN
        sut.searchText = "The"
        // simulates async functions that take some time to run, and throws and error
        mockDataProvider.executeAfterSleep(extraTime: 1) {
            mockDataProvider.error = .unknown
        }
        
        // THEN
        waitForExpectations(timeout: 10)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func makeSUT() -> (ShowSearchInteractor, MockTVmazeAPIDataProvider) {
        let mockDataProvider = MockTVmazeAPIDataProvider()
        return (ShowSearchInteractor(dataProvider: mockDataProvider), mockDataProvider)
    }

}
