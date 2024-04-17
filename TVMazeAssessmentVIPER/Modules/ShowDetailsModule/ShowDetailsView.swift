//
//  ShowDetailsView.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import SwiftUI

struct ShowDetailsView: View {
    @ObservedObject var presenter: ShowDetailsPresenter
    private let router = EpisodeDetailsRouter()
    private let show: Show
    @State private var selectedSeason: Int = 0
    init(show: Show, presenter: ShowDetailsPresenter) {
        self.show = show
        self.presenter = presenter
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollViewReader { scrollReader in
                ScrollView {
                    VStack {
                        if let url = show.mediumPosterURL {
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
                        
                        Spacer()
                            .frame(height: 16)
                        if !show.schedule.days.isEmpty {
                            LabeledContent("Airing days:", value: show.schedule.days.joined(separator: ", "))
                                .padding(.bottom, 8)
                        }
                        if !show.schedule.time.isEmpty {
                            LabeledContent("Air time:", value: show.schedule.time)
                                .padding(.bottom, 8)
                        }
                        LabeledContent("Genres", value: show.genres.joined(separator: ", "))
                            .padding(.bottom, 8)
                        if let summary = show.summary?.removingHTMLTags {
                            LabeledContent("Summary:", value: summary)
                                .padding(.bottom, 8)
                        }
                        
                        if presenter.isLoading {
                            presenter.buildProgressView()
                        } else {
                            Divider()
                            ForEach(presenter.seasons, id: \.number) { season in
                                VStack(alignment: .leading, spacing: 0) {
                                    Spacer()
                                    HStack(spacing: 0) {
                                        Text("Season \(season.number)")
                                            .font(.title2)
                                            .fontWeight(selectedSeason == season.number ? .bold : .regular)
                                        Spacer()
                                        Text("\(season.episodes.count) episodes")
                                            .padding(.trailing, 4)
                                        if season.number == selectedSeason {
                                            Image(systemName: "arrow.down")
                                        } else {
                                            Image(systemName: "arrow.right")
                                        }
                                    }
                                    .frame(height: 30)
                                    
                                    Spacer()
                                    Divider()
                                }
                                .frame(height: 40)
                                .id(season.number)
                                .onTapGesture {
                                    withAnimation {
                                        if selectedSeason == season.number {
                                            selectedSeason = 0
                                        } else {
                                            selectedSeason = season.number
                                            scrollReader.scrollTo(selectedSeason, anchor: .top)
                                        }
                                    }
                                }
                                
                                if selectedSeason == season.number {
                                    ForEach(season.episodes, id: \.id) { episode in
                                        router.makeShowDetailLink(for: episode)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            presenter.onAppear()
        }
        .navigationTitle(show.name)
        .padding(.horizontal, 16)
    }
}


#Preview {
    ShowDetailsView(
        show: Show(),
        presenter: ShowDetailsPresenter(
            interactor: ShowDetailsInteractor(
                dataProvider: TVmazeAPIDataProvider(),
                show: Show()
            )
        )
    )
}

