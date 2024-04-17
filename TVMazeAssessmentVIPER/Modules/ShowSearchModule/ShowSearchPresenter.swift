//
//  ShowSearchViewPresenter.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import SwiftUI
import Combine

class ShowSearchPresenter: ObservableObject {
    @ObservedObject private var interactor: ShowSearchInteractor
    @Published var shows: [Show] = []
    @Published var isLoading: Bool = false
    @Published var showErrorMessage: Bool = false
    @Published var errorMessage: String = ""
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: ShowSearchInteractor) {
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
        
        interactor.$errorMessage
            .assign(to: \.errorMessage, on: self)
            .store(in: &cancellables)
    }
    
    func buildTextView() -> some View {
        TextField("Type at least 2 letters", text: $interactor.searchText)
            .textFieldStyle(.roundedBorder)
            .frame(height: 32)
            .padding(.top, 12)
            .padding(.horizontal, 16)
    }
    
    func linkBuilder<Content: View>(for show: Show, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: content) {
            ShowRowView(show: show)
        }
    }
    
    func buildAlertOKButton() -> some View {
        Button("OK") { [unowned self] in
            interactor.showErrorMessage = false
            interactor.errorMessage = ""
        }
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
}
