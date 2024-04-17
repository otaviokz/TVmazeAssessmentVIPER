//
//  ShowSearchViewInteractor.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import SwiftUI

class ShowSearchInteractor: ObservableObject {
    private var dataProvider: TVmazeAPIDataProviderType
    static var searchDelay: TimeInterval = 1
    var timer: Timer?
    @Published var shows: [Show] = []
    @Published var isLoading: Bool = false
    @Published var showErrorMessage: Bool = false
    @Published var errorMessage: String = ""
    @Published var searchText: String = "" {
        didSet {
            if searchText.searchSanitised.count >= 2 {
                // Fixes bug where focusing and unfocusing the TextField whold be seen as
                // changing searchText, resulting in new launch of a search timer
                if oldValue.searchSanitised != searchText.searchSanitised {
                    launchSearchTimer()
                }
                
            } else {
                shows = []
                timer?.invalidate()
            }
        }
    }
    
    init(dataProvider: TVmazeAPIDataProviderType) {
        self.dataProvider = dataProvider
    }
    
    @MainActor
    private func searchShows() async {
        showErrorMessage = false
        isLoading = true
        do {
            shows = try await dataProvider.searchShows(query: searchText)
            isLoading = false
        } catch {
            print(error.localizedDescription)
            isLoading = false
            showErrorMessage = true
            errorMessage = "Unable to search for '\(searchText.searchSanitised)', please try again later."
        }
    }
    
    private func launchSearchTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: Self.searchDelay, repeats: false) { [unowned self] _ in
            Task {
                await searchShows()
            }
        }
    }
    
    func linkBuilder<Content: View>(for show: Show, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: content) {
            ShowRowView(show: show)
        }
    }
}
