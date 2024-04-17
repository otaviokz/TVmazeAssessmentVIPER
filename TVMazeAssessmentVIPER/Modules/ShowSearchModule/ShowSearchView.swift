//
//  ShowSearchView.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import SwiftUI

struct ShowSearchView: View {
    @ObservedObject private var presenter: ShowSearchPresenter
    
    init(presenter: ShowSearchPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            if presenter.isLoading {
                Spacer()
                presenter.buildProgressView()
                Spacer()
            } else {
                presenter.buildTextView()
                
                VStack(alignment: .center, spacing: 0) {
                    List {
                        ForEach(presenter.shows, id: \.id) { show in
                            presenter.linkBuilder(for: show) {
                                EmptyView()
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .cornerRadius(16)
                }
            }
        }
        .alert(presenter.errorMessage, isPresented: $presenter.showErrorMessage) {
            presenter.buildAlertOKButton()
        }
        .navigationTitle("Search")
    }    
}

#Preview {
    NavigationStack {
        ShowSearchView(
            presenter: ShowSearchPresenter(
                interactor: ShowSearchInteractor(
                    dataProvider: TVmazeAPIDataProvider()
                )
            )
        )
    }
}
