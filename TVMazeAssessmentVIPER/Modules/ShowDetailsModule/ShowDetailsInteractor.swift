//
//  ShowDetailsInteractor.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import Foundation

class ShowDetailsInteractor: ObservableObject {
    private let dataProvider: TVmazeAPIDataProviderType
    private let show: Show
    @Published var seasons: [Season] = []
    @Published var isLoading: Bool = false
    
    init(dataProvider: TVmazeAPIDataProviderType, show: Show) {
        self.show = show
        self.dataProvider = dataProvider
    }
    
    func fetchShowEpisodes() {
        Task {
            await searchSeriesAndEpisodes(showId: show.id)
        }
    }
    
    @MainActor
    private func searchSeriesAndEpisodes(showId: Int) async {
        isLoading = true
        do {
            let episodes = try await dataProvider.fetchEpisodes(showId: showId)
            seasons = episodes.seasons
            isLoading = false
        } catch {
            print(error.localizedDescription)
            isLoading = false
        }
    }
}
