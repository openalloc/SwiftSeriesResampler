//
//  ArrayMinAndMaxTests.swift
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

final class ArrayMinAndMaxTests: XCTestCase {
    func testEmpty() throws {
        let items: [Int] = []
        let actual = items.minAndMax
        XCTAssertNil(actual)
    }

    func testOneZero() throws {
        let items: [Int] = [0]
        let actual = items.minAndMax!
        let expected = (min: 0, max: 0)
        XCTAssertEqual(expected.min, actual.min)
        XCTAssertEqual(expected.max, actual.max)
    }

    func testTwoZeroes() throws {
        let items: [Int] = [0, 0]
        let actual = items.minAndMax!
        let expected = (min: 0, max: 0)
        XCTAssertEqual(expected.min, actual.min)
        XCTAssertEqual(expected.max, actual.max)
    }

    func testVarious() throws {
        let items: [Int] = [0, 13, -3, 200, -400, 18, 0, 3]
        let actual = items.minAndMax!
        let expected = (min: -400, max: 200)
        XCTAssertEqual(expected.min, actual.min)
        XCTAssertEqual(expected.max, actual.max)
    }

    // TODO: this may not be desired behavior
    func testNan() throws {
        let items: [Double] = [Double.nan]
        let actual = items.minAndMax!
        XCTAssertTrue(actual.min.isNaN)
        XCTAssertTrue(actual.max.isNaN)
    }

    // TODO: this may not be desired behavior
    func testNanInFirstPositionAndVarious() throws {
        let items: [Double] = [Double.nan, 4, -3, 0]
        let actual = items.minAndMax!
        XCTAssertTrue(actual.min.isNaN)
        XCTAssertTrue(actual.max.isNaN)
    }

    func testNanInSecondPositionAndVarious() throws {
        let items: [Double] = [2, Double.nan, 4, -3, 0]
        let actual = items.minAndMax!
        let expected = (min: -3.0, max: 4.0)
        XCTAssertEqual(expected.min, actual.min)
        XCTAssertEqual(expected.max, actual.max)
    }

    // TODO: this may not be desired behavior
    func testInf() throws {
        let items: [Double] = [Double.infinity]
        let actual = items.minAndMax!
        XCTAssertTrue(actual.min.isInfinite)
        XCTAssertTrue(actual.max.isInfinite)
    }

    func testNegInf() throws {
        let items: [Double] = [-Double.infinity]
        let actual = items.minAndMax!
        XCTAssertTrue(actual.min.isInfinite)
        XCTAssertTrue(actual.max.isInfinite)
    }

    func testTwoInf() throws {
        let items: [Double] = [Double.infinity, -Double.infinity]
        let actual = items.minAndMax!
        let expected = (min: -Double.infinity, max: Double.infinity)
        XCTAssertEqual(expected.min, actual.min)
        XCTAssertEqual(expected.max, actual.max)
        XCTAssertTrue(actual.min.isInfinite)
        XCTAssertTrue(actual.max.isInfinite)
    }

    func testOnePositiveInfOneNanAndVarious() throws {
        let items: [Double] = [3, -300, -Double.infinity, Double.nan, 200, -4]
        let actual = items.minAndMax!
        let expected = (min: -Double.infinity, max: 200.0)
        XCTAssertEqual(expected.min, actual.min)
        XCTAssertEqual(expected.max, actual.max)
        XCTAssertTrue(actual.min.isInfinite)
        XCTAssertFalse(actual.max.isInfinite)
    }
}
