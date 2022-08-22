//
//  BaseSeriesSamplerTests.swift
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

final class BaseSeriesSamplerTests: XCTestCase {
    public func testResample1a() throws {
        guard let s = AccelLerpResamplerD([100, 200, 400], targetCount: 5) else { XCTFail(); return }
        XCTAssertEqual([0.0, 1.0, 4.0], s.targetIndices)
        let actual = s.resample([2, 5, 7])
        let expected: [Double] = [2.0, 5.0, 5.666, 6.333, 7.0]
        XCTAssertEqual(expected, actual, accuracy: 0.001)
    }

    public func testResample1b() throws {
        guard let s = AccelLerpResamplerD([100, 200, 400], targetCount: 5) else { XCTFail(); return }
        XCTAssertEqual([0.0, 1.0, 4.0], s.targetIndices)
        let actual = s.resample([2, 6, 7])
        let expected: [Double] = [2.0, 6.0, 6.333, 6.666, 7.0]
        XCTAssertEqual(expected, actual, accuracy: 0.001)
    }

    public func testResample2a() throws {
        guard let s = LerpResampler([100, 200, 400], targetCount: 5) else { XCTFail(); return }
        let actual = s.resample([2, 5, 7])
        let expected: [Double] = [2, 4.25, 5.5, 6.25, 7]
        XCTAssertEqual(expected, actual, accuracy: 0.001)
    }

    public func testResample2b() throws {
        guard let s = LerpResampler([100, 200, 400], targetCount: 5) else { XCTFail(); return }
        let actual = s.resample([2, 6, 7])
        let expected: [Double] = [2, 5, 6.25, 6.625, 7]
        XCTAssertEqual(expected, actual, accuracy: 0.001)
    }
    
    public func testExample() throws {
        let df = ISO8601DateFormatter()
        let d1 = df.date(from: "2020-06-01T10:00:00Z")!
        let d2 = df.date(from: "2020-06-20T08:00:00Z")!
        let d3 = df.date(from: "2020-06-28T09:00:00Z")!
        let d4 = df.date(from: "2020-07-18T11:00:00Z")!
        let d5 = df.date(from: "2020-07-30T13:00:00Z")!
        
        let intervals = [d1, d2, d3, d4, d5].map { $0.timeIntervalSinceReferenceDate }
        let marketValues = [1300.0, 1600.0, 1200.0, 800.0, 1500.0]
        
        guard let s = LerpResampler(intervals, targetCount: 8) else { XCTFail(); return }
        let actual = s.resample(marketValues)
        let expected: [Double] = [1300, 1434, 1568, 1281, 1064, 896, 1011, 1500]
        XCTAssertEqual(expected, actual, accuracy: 1.0)
        
        //for pair in zip(s.targetVals, actual) {
        //    let d = Date(timeIntervalSinceReferenceDate: pair.0)
        //    print(String(format: "%@: $%5.0f", df.string(from: d), pair.1))
        //}
        
        /*
         LerpResampler
         2020-06-01T10:00:00Z: $ 1300
         2020-06-09T20:42:51Z: $ 1434
         2020-06-18T07:25:42Z: $ 1568
         2020-06-26T18:08:34Z: $ 1281
         2020-07-05T04:51:25Z: $ 1064
         2020-07-13T15:34:17Z: $  896
         2020-07-22T02:17:08Z: $ 1011
         2020-07-30T13:00:00Z: $ 1500

         AccelLerpResamplerD
         2020-06-01T10:00:00Z: $ 1300
         2020-06-09T20:42:51Z: $ 1450
         2020-06-18T07:25:42Z: $ 1600
         2020-06-26T18:08:34Z: $ 1200
         2020-07-05T04:51:25Z: $ 1067
         2020-07-13T15:34:17Z: $  933
         2020-07-22T02:17:08Z: $  800
         2020-07-30T13:00:00Z: $ 1500
         */
    }
}
