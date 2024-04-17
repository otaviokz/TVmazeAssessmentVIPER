//
//  Image+Formatting.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import SwiftUI

extension Image {
    var posterFormat: some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 320)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    @MainActor func cacheImage(url: URL) -> some View {
        ImageCache.shared[url] = self
        return  posterFormat//formatted(image: image)
    }
}
