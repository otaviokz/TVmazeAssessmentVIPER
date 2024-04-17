//
//  String+SearchSanitising.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import Foundation

extension String {
    var searchSanitised: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
