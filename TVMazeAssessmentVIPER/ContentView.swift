//
//  ContentView.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 16/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                PagedShowsView(
                    presenter: PagedShowsPresenter(
                        interactor: PagedShowsInterator(
                            dataProvider: TVmazeAPIDataProvider()
                        )
                    )
                )
            }.tabItem {
                Label("All shows", systemImage: "tv")
            }
            
            NavigationView {
                ShowSearchView(
                    presenter: ShowSearchPresenter(
                        interactor: ShowSearchInteractor(
                            dataProvider: TVmazeAPIDataProvider()
                        )
                    )
                )
            }.tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
    }
}

#Preview {
    ContentView()
}
