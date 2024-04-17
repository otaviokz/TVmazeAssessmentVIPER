//
//  EpisodeDetailsView.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import SwiftUI

struct EpisodeDetailsView: View {
    let episode: Episode
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 12) {
                    if let url = episode.mediumPosterURL {
                        if let poster = ImageCache.shared[url] {
                            poster
                                .posterFormat
                        } else {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                    case .success(let image):
                                        image.cacheImage(url: url)
                                    default:
                                        Image(systemName: "photo").posterFormat
                                }
                            }
                        }
                    }
                    LabeledContent("Number:", value: "\(episode.number)")
                    LabeledContent("Season:", value: "\(episode.seasonNumber)")
                    if let summary = episode.summary?.removingHTMLTags {
                        LabeledContent("Summary:", value: summary)
                    }
                }
            }
        }
        .navigationTitle(episode.name)
        .padding(.horizontal, 32)
    }
}

#Preview {
    EpisodeDetailsView(episode: Episode())
}
