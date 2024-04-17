//
//  ShowDetailsInteractorTests.swift
//  TVMazeAssessmentVIPERTests
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import XCTest
import XCTest_BlockExpectations
@testable import TVMazeAssessmentVIPER

final class ShowDetailsInteractorTests: XCTestCase {
 
    func testFetchEpisodes_HappyPath() {
        let (sut, mockDataProvider) = makeSut()
        
        // GIVEN
        _ = blockExpectation {
            // THEN
            sut.seasons.isEmpty &&
            sut.isLoading == true
        }
        
        _ = blockExpectation {
            // THEN
            sut.seasons.isEmpty == false &&
            sut.isLoading == false
        }
        
        // WHEN
        sut.fetchShowEpisodes()
        
        mockDataProvider.executeAfterSleep {
            mockDataProvider.episodes = JSONLoader.showEpisodesSample()
        }
        
        // THEN
        waitForExpectations(timeout: 10)
    }
    
    func testFetchEpisodes_ExceptionThrown() {
        let (sut, mockDataProvider) = makeSut()
        
        // GIVEN
        _ = blockExpectation {
            // THEN
            sut.seasons.isEmpty &&
            sut.isLoading == true
        }
        
        _ = blockExpectation {
            // THEN
            sut.seasons.isEmpty &&
            sut.isLoading == false
        }
        
        // WHEN
        sut.fetchShowEpisodes()
        
        mockDataProvider.executeAfterSleep {
            mockDataProvider.error = TVmazeAPIDataProviderAPIClientError.unknown
        }
        
        // THEN
        waitForExpectations(timeout: 10)
    }
    
    func makeSut() -> (ShowDetailsInteractor, MockTVmazeAPIDataProvider) {
        let mockDataProvider = MockTVmazeAPIDataProvider()
        let interactor = ShowDetailsInteractor(dataProvider: mockDataProvider, show: Show())
        return (interactor, mockDataProvider)
    }
}
