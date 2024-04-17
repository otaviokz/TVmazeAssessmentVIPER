//
//  SampleEntities.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 16/04/2024.
//

import Foundation
import SwiftUI

extension Show {
    init() {
        id = 1
        name = "Under the Dome"
        images = Images(medium: "", original: "")
        genres = ["Drama", "Science-Fiction", "Thriller"]
        summary = "People wake up one day and theres a dome enclosing their city. Drama ensues."
        schedule = Schedule(time: "22:00", days: ["Wednesday"])
        premiered = "2013-06-24"
        ended = "2015-09-10"
    }
}
