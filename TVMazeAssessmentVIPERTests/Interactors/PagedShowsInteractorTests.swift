//
//  PagedShowsInteractorTests.swift
//  TVMazeAssessmentVIPERTests
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import XCTest
import XCTest_BlockExpectations
@testable import TVMazeAssessmentVIPER

final class PagedShowsInteractorTests: XCTestCase {
    func testFetchPagedShows_OnAppear() throws {
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
        sut.onAppear()
        // Simulates async call that runs asynchronously and successfuly returns a shows array
        mockDataProvider.executeAfterSleep {
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
            sut.errorMessage == "Unable to load shows, please try again later." &&
            sut.selectedPage == 0
        }
        
        // WHEN
        sut.fetchShowsForNextPage()
        // simulates async functions that take some time to run, and throws and error
        mockDataProvider.executeAfterSleep {
            mockDataProvider.error = .unknown
        }
        
        // THEN
        waitForExpectations(timeout: 10)
    }
    
    func makeSUT() -> (PagedShowsInterator, MockTVmazeAPIDataProvider) {
        let mockDataProvider = MockTVmazeAPIDataProvider()
        return (PagedShowsInterator(dataProvider: mockDataProvider), mockDataProvider)
    }
}
