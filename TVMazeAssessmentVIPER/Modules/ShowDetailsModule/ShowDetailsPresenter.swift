//
//  ShowDetailsPresenter.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import SwiftUI
import Combine

class ShowDetailsPresenter: ObservableObject {
    @ObservedObject private var interactor: ShowDetailsInteractor
    @Published var seasons: [Season] = []
    @Published var isLoading: Bool = false
    var selectedSeason: Int = 0
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: ShowDetailsInteractor) {
        self.interactor = interactor
        
        interactor.$seasons
            .assign(to: \.seasons, on: self)
            .store(in: &cancellables)
        
        interactor.$isLoading
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
    }
    
    func buildProgressView() -> some View {
        if #available(iOS 17.0, *) {
            ProgressView()
                .controlSize(.extraLarge)
        } else {
            ProgressView()
                .controlSize(.large)
        }
    }
    
    func onAppear() {
        interactor.fetchShowEpisodes()
    }
}
