//
//  ShowDetailsRouter.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import SwiftUI

class ShowDetailsRouter {
    func makeDetailView(for show: Show) -> some View {
        let presenter = ShowDetailsPresenter(
            interactor: ShowDetailsInteractor(dataProvider: TVmazeAPIDataProvider(), show: show)
        )
        return ShowDetailsView(show: show, presenter: presenter)
    }
}
