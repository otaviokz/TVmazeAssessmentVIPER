//
//  EpisodeDetailsRouter.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import SwiftUI

class EpisodeDetailsRouter {
    func makeShowDetailLink(for episode: Episode) -> some View {
        NavigationLink(
            destination: EpisodeDetailsView(episode: episode)
        ) {
            EpisodeRowView(episode: episode)
        }
    }
}
