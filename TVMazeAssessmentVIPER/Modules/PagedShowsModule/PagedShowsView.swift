//
//  PagedShowsView.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 16/04/2024.
//

import SwiftUI

struct PagedShowsView: View {
    @ObservedObject var presenter: PagedShowsPresenter
    
    var body: some View {
        VStack {
            if presenter.isLoading {
                Spacer()
                if #available(iOS 17.0, *) {
                    ProgressView()
                        .controlSize(.extraLarge)
                } else {
                    ProgressView()
                        .controlSize(.large)
                }
                Spacer()
            } else {
                List {
                    ForEach(presenter.shows, id: \.id) { show in
                        presenter.linkBuilder(for: show) {
                            EmptyView()
                        }
                    }
                }
                HStack(alignment: .center) {
                    presenter.makePreviousPageButton()
                    Spacer()
                    Text("\(presenter.selectedPage + 1)")
                    Spacer()
                    presenter.makeNextPageButton()
                }
                .padding(.horizontal, 32)
                .frame(height: 40)
            }
        }
        .alert(presenter.errorMessage, isPresented: $presenter.showErrorMessage) {
            Button("OK") {
                presenter.showErrorMessage = false
            }
        }
        .onAppear {
            presenter.onAppear()
        }
        .navigationTitle("Shows")
    }
}

#Preview {
    PagedShowsView(presenter: PagedShowsPresenter(interactor: PagedShowsInterator(dataProvider: TVmazeAPIDataProvider())))
}
