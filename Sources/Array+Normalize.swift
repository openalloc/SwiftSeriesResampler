//
//  Array+Normalize.swift
//
// Copyright 2021 FlowAllocator LLC
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

import Foundation

extension Array where Element: Comparable & BinaryFloatingPoint {
    /// normalize an array of values to a target range
    ///
    /// [0, 4, 5, 10] to a target of 0...10 is [0, 4, 5, 10]
    /// [0, 4, 5, 10] to a target of 0...20 is [0, 8, 10, 20]
    /// [0, 4, 5, 10] to a target of 1...10 is [1.0, 4.6, 5.5, 10.0]
    /// [4, 10, 0, 5] to a target of 0...10 is [4, 10, 0, 5]
    /// [1, 2] to a target of [1...10] is [1, 10]
    ///
    /// Optionally specify the minimum/maximum of the source values. If not provided, this array
    /// will be scanned for minimum and maximum values to determine the interval used for normalization.
    ///
    /// Used in preparation for vDSP.linearInterpolate()
    ///
    func normalize(to dst: ClosedRange<Element>,
                   from srcMinMax: (min: Element, max: Element)? = nil) -> [Element]?
    {
        guard let _srcMinMax = srcMinMax ?? minAndMax else { return nil }
        let srcExtent = _srcMinMax.max - _srcMinMax.min
        guard srcExtent != 0 else { return nil }
        let dstExtent = dst.upperBound - dst.lowerBound
        let factor = dstExtent / srcExtent
        return map { dst.lowerBound + (($0 - _srcMinMax.min) * factor) }
    }
}
