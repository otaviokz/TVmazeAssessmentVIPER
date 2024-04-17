//
//  ShowDetailRouter.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import SwiftUI

class ShowDetailRouter {
    func makeShowDetailLink(for show: Show) -> some View {
        NavigationLink(
            destination: ShowDetailsView(
                show: show,
                presenter: ShowDetailsPresenter(
                    interactor: ShowDetailsInteractor(
                        dataProvider: TVmazeAPIDataProvider(), show: show
                    )
                )
            )
        ) {
            ShowRowView(show: show)
        }
    }
}
