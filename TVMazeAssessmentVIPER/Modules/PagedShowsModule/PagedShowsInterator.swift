//
//  PagedShowsInterator.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 16/04/2024.
//

import SwiftUI

enum PageChange {
    case next
    case previous
    case firstPage
}

class PagedShowsInterator: ObservableObject {
    private var dataProvider: TVmazeAPIDataProviderType
    @Published var shows: [Show] = []
    @Published var isLoading: Bool = false
    @Published var showErrorMessage: Bool = false
    @Published var errorMessage: String = ""
    @Published var selectedPage = 0
    
    init(dataProvider: TVmazeAPIDataProviderType) {
        self.dataProvider = dataProvider
    }
    
    private func fetchShowsForCurrentPage(pageChange: PageChange) {
        Task {
            await searchShows(pageChange: pageChange)
        }
    }
    
    @MainActor
    private func searchShows(pageChange: PageChange) async {
        showErrorMessage = false
        
        switch pageChange {
            case .next: selectedPage += 1
            case .previous: selectedPage -= 1
            case .firstPage: selectedPage = 0
        }
        
        do {
            isLoading = true
            shows = try await dataProvider.fetchShows(page: selectedPage)
            isLoading = false
        } catch {
            switch pageChange {
                case .next: selectedPage -= 1
                case .previous: selectedPage += 1
                case .firstPage: break
            }
            
            print(error.localizedDescription)
            isLoading = false
            showErrorMessage = true
            errorMessage = "Unable to load shows, please try again later."
        }
    }
    
    func fetchShowsForNextPage() {
        fetchShowsForCurrentPage(pageChange: .next)
    }
    
    func fetchShowsForPreviousPage() {
        guard selectedPage > 0 else { return }
        fetchShowsForCurrentPage(pageChange: .previous)
    }
    
    func onAppear() {
        if shows.isEmpty {
            selectedPage = 0
            fetchShowsForCurrentPage(pageChange: .firstPage)
        }
    }
}
