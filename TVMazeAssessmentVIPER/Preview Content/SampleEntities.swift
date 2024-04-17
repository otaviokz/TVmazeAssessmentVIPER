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

extension Episode {
    init() {
        self.id = 185054
        self.name = "The Enemy Within"
        self.number = 16
        self.seasonNumber = 13
        self.summary = "<p>As the Dome in Chester's Mill comes down, the Resistance makes a final attempt to protect the outside world from the infected townspeople in the Kinship and their new queen.</p>"
        self.images = Images(medium: "www.images.com/medium.png", original: "www.images.com/original.png")
    }
}
