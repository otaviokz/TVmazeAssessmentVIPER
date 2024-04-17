//
//  String+RemoveHTMLTags.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import Foundation

extension String {
    var removingHTMLTags: String {
        self
            .replacingOccurrences(of: "<p>", with: "\n\n")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
            .replacingOccurrences(of: "<br>", with: "\n\n")
            .replacingOccurrences(of: "<br \\>", with: "\n\n")
    }
}
