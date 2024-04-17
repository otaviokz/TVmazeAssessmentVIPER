//
//  PagedShowsPresenter.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 16/04/2024.
//

import SwiftUI
import Combine

class PagedShowsPresenter: ObservableObject {
    @Published var shows: [Show] = []
    @Published var isLoading: Bool = false
    @Published var showErrorMessage: Bool = false
    @Published var errorMessage: String = ""
    @Published var showPreviousPageButton: Bool = false
    @Published var selectedPage: Int = 0
    private let interactor: PagedShowsInterator
    private let router = ShowDetailRouter()
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: PagedShowsInterator) {
        self.interactor = interactor
        
        interactor.$shows
            .assign(to: \.shows, on: self)
            .store(in: &cancellables)
        
        interactor.$isLoading
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
        
        interactor.$showErrorMessage
            .assign(to: \.showErrorMessage, on: self)
            .store(in: &cancellables)
        
        interactor.$selectedPage.map { $0 > 0 }
            .assign(to: \.showPreviousPageButton, on: self)
            .store(in: &cancellables)
        
        interactor.$selectedPage
            .assign(to: \.selectedPage, on: self)
            .store(in: &cancellables)
        
        interactor.$errorMessage
            .assign(to: \.errorMessage, on: self)
            .store(in: &cancellables)
    }
    
    func onAppear() {
        interactor.onAppear()
    }
    
    func buildPreviousPageButton() -> some View {
        Button(action: interactor.fetchShowsForPreviousPage) {
            Image(systemName: "arrow.left")
        }
        .disabled(selectedPage < 1)
        .fontWeight(.bold)
    }
    
    func buildNextPageButton() -> some View {
        Button(action: interactor.fetchShowsForNextPage) {
            Image(systemName: "arrow.right")
        }
        .fontWeight(.bold)
    }
    
    func linkBuilder<Content: View>(for show: Show, @ViewBuilder content: () -> Content) -> some View {
        router.makeShowDetailLink(for: show)
    }
    
    func buildAlertOKButton() -> some View {
        Button("OK") { [unowned self] in
            interactor.showErrorMessage = false
            interactor.errorMessage = ""
        }
    }
}

