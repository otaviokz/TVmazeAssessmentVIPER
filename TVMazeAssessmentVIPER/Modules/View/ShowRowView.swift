//
//  ShowRowView.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 16/04/2024.
//

import SwiftUI

struct ShowRowView: View {
    let show: Show
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(show.name)
                .font(.headline)
            Spacer()
            if let url = show.mediumPosterURL {
                if let image = ImageCache.shared[url] {
                    image
                        .formattedForShowRowView()
                } else {
                    AsyncImage(url: url) { phase in
                        switch phase {
                            case .success(let image):
                                cacheImage(url: url, image: image)
                                    .formattedForShowRowView()
                            default:
                                Image(systemName: "photo")
                                    .formattedForShowRowView()
                        }
                    }
                }
            }
        }
        .frame(height: 82)
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
    
    @MainActor func cacheImage(url: URL, image: Image) -> Image {
        ImageCache.shared[url] = image
        return image
    }
}

#Preview {
    ShowRowView(show: Show())
        .previewLayout(.sizeThatFits)
}

private extension Image {
    func formattedForShowRowView() -> some View {
        self
            .resizable()
            .frame(width: 74, height: 74)
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
