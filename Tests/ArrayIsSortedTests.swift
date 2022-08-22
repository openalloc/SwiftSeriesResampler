//
//  ArrayIsSortedTests.swift
//
// Copyright 2021, 2022 OpenAlloc LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import XCTest

@testable import SeriesResampler

final class ArrayIsSortedTests: XCTestCase {
    func testEmpty() throws {
        let items: [Int] = []
        XCTAssertTrue(items.isAscending())
        XCTAssertTrue(items.isDescending())
        XCTAssertTrue(items.isAscending(strict: true))
        XCTAssertTrue(items.isDescending(strict: true))

    }

    func testOne() throws {
        let items: [Int] = [5]
        XCTAssertTrue(items.isAscending())
        XCTAssertTrue(items.isDescending())
        XCTAssertTrue(items.isAscending(strict: true))
        XCTAssertTrue(items.isDescending(strict: true))
    }
    
    func testTwoAscending() throws {
        let items: [Int] = [5, 7]
        XCTAssertTrue(items.isAscending())
        XCTAssertFalse(items.isDescending())
        XCTAssertTrue(items.isAscending(strict: true))
        XCTAssertFalse(items.isDescending(strict: true))
    }
    
    func testTwoDescending() throws {
        let items: [Int] = [7, -1]
        XCTAssertFalse(items.isAscending())
        XCTAssertTrue(items.isDescending())
        XCTAssertFalse(items.isAscending(strict: true))
        XCTAssertTrue(items.isDescending(strict: true))
    }
    
    func testStrict() throws {
        let items: [Int] = [5, 5]
        XCTAssertFalse(items.isAscending(strict: true))
        XCTAssertFalse(items.isDescending(strict: true))
    }
    
    func testThreeStrictBefore() throws {
        let items: [Int] = [1, 5, 5]
        XCTAssertFalse(items.isAscending(strict: true))
        XCTAssertFalse(items.isDescending(strict: true))
    }
    
    func testThreeStrictAfter() throws {
        let items: [Int] = [5, 5, 7]
        XCTAssertFalse(items.isAscending(strict: true))
        XCTAssertFalse(items.isDescending(strict: true))
    }
}
