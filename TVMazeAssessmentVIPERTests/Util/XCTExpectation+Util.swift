//
//  XCTExpectation+Util.swift
//  TVMazeAssessmentVIPERTests
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import XCTest

public extension XCTestCase {
    func blockExpectation(block: @escaping () -> Bool) -> XCTestExpectation {
        let evaluation: () -> Bool = { block() == true }
        return expectation(for: NSPredicate(block: { _, _ in
            evaluation()
        }), evaluatedWith: evaluation())
        
    }
}
