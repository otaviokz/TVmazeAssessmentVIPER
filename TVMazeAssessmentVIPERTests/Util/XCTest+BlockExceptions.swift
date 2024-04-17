//
//  XCTest+BlockExceptions.swift
//  TVMazeAssessmentVIPERTests
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import XCTest

/// Summary
/// Continualy run block until either it evaluates to true or 'waitForExpectatios' times out
///
/// Declaration
/// public blockExpectation(block: @escaping () -> Bool)
///
/// Parameters
///     block        a  () -> Bool code block that evalueates to eother true of false
///
/// Returns
/// XCTestExpectation
public extension XCTestCase {
    func blockExpectation(block: @escaping () -> Bool) -> XCTestExpectation {
        let evaluation: () -> Bool = { block() == true }
        return expectation(for: NSPredicate(block: { _, _ in
            evaluation()
        }), evaluatedWith: evaluation())
    }
}
