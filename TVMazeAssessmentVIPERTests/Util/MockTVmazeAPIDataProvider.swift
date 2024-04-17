//
//  MockTVmazeAPIDataProvider.swift
//  TVMazeAssessmentVIPERTests
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import Foundation
@testable import TVMazeAssessmentVIPER

class MockTVmazeAPIDataProvider: TVmazeAPIDataProviderType {
    var episodes: [Episode]?
    func fetchEpisodes(showId: Int) async throws -> [Episode] {
        while true {
            if let error = error {
                throw error
            } else if let episodes = episodes, !episodes.isEmpty {
                return episodes
            }
            
            // Sleep 1 second when there's no episodes to return ot error to throw
            sleep(1)
        }
    }
    
    var shows: [Show]?
    var error: TVmazeAPIDataProviderAPIClientError?
    func searchShows(query: String) async throws -> [Show] {
        while true {
            if let error = error {
                throw error
            } else if let shows = shows, !shows.isEmpty {
                return shows
            }
            
            // Sleep 1 second when there's no shows to return ot error to throw
            sleep(1)
        }
    }
    
    func fetchShows(page: Int) async throws -> [Show] {
        while true {
            if let error = error {
                throw error
            } else if let shows = shows, !shows.isEmpty {
                return page == 0 ? JSONLoader.showSearchSamplePage0() : JSONLoader.showSearchSamplePage1()
            } else {
                // Sleep 1 second when there's no shows to return or error throw
                sleep(1)
            }
        }
    }
    
    let defaultShows = JSONLoader.showSearchSample()
    let defaultEpisodes = JSONLoader.showEpisodesSample()
    let defaultSeasons = JSONLoader.showEpisodesSample().seasons
    
    /// Executes block after fetch funcs  sleep(1)  cycle, simulating  execution of async 'fetch' methods, delaying immediate return of said methods. 
    /// ```
    /// DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1.25) {
    ///     block()
    /// }
    /// ```
    ///
    /// - Parameters:
    ///     - block: 
    ///           Should either set either 'shows' to a non empty value when calling a func that fetch shows
    ///           or  'episodes' to a non empty value in the when calling a func that fetch episodes
    ///           or 'error'  to a non null value for both of the above cases
    func executeAfterSleep(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1.25) {
            block()
        }
    }
}

