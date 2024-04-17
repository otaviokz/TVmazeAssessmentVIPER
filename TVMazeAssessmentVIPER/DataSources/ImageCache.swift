//
//  ImageCache.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 16/04/2024.
//

import Foundation
import SwiftUI

class ImageCache {
    static var shared = ImageCache()
    private var cache: [URL: Image] = [:]
    
    private init() { }
    
    @MainActor
    subscript(url: URL) -> Image? {
        get {
            cache[url]
        }
        set(newValue) {
            cache[url] = newValue
        }
    }
}
