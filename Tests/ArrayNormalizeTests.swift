//
//  ArrayNormalizeTests.swift
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

final class ArrayNormalizeTests: XCTestCase {
    func testIdentity() throws {
        let actual = [0, 4, 5, 10].normalize(to: 0 ... 10)!
        let expected: [Double] = [0, 4, 5, 10]
        XCTAssertEqual(expected, actual)
    }

    func testIdentityUnordered() throws {
        let actual = [4, 10, 0, 5].normalize(to: 0 ... 10)!
        let expected: [Double] = [4, 10, 0, 5]
        XCTAssertEqual(expected, actual)
    }

    func testDoubleIdentity() throws {
        let actual = [0, 4, 5, 10].normalize(to: 0 ... 20)!
        let expected: [Double] = [0, 8, 10, 20]
        XCTAssertEqual(expected, actual)
    }

    func testFrom1() throws {
        let actual = [0, 4, 5, 10].normalize(to: 1 ... 10)!
        let expected: [Double] = [1.0, 4.6, 5.5, 10.0]
        XCTAssertEqual(expected, actual)
    }

    func testFrom1unordered() throws {
        let actual = [4, 10, 0, 5].normalize(to: 1 ... 10)!
        let expected: [Double] = [4.6, 10.0, 1.0, 5.5]
        XCTAssertEqual(expected, actual)
    }

    func testHomogenous0() throws {
        let actual = [0, 0, 0, 0].normalize(to: 1 ... 10)
        XCTAssertNil(actual)
    }

    func testHomogenous20() throws {
        let actual = [20, 20, 20, 20].normalize(to: 1 ... 10)
        XCTAssertNil(actual)
    }

    func testEmpty() throws {
        let actual = [].normalize(to: 1 ... 10)
        XCTAssertNil(actual)
    }

    func testOne() throws {
        let actual = [1].normalize(to: 1 ... 10)
        XCTAssertNil(actual)
    }

    func testTwo() throws {
        let actual = [1, 2].normalize(to: 1 ... 10)!
        let expected: [Double] = [1.0, 10.0]
        XCTAssertEqual(expected, actual)
    }
}
