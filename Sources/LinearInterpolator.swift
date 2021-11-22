//
//  LinearInterpolator.swift
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

/// A pure-Swift implementation of a linear interpolator.
public struct LinearInterpolator<T>
    where T: BinaryFloatingPoint
{
    @usableFromInline
    internal let n: Int

    @usableFromInline
    internal let xVals: [T]

    @usableFromInline
    internal let yVals: [T]

    public init(xVals: [T], yVals: [T]) {
        assert(xVals.count == yVals.count)
        n = xVals.count - 1
        self.xVals = xVals
        self.yVals = yVals
    }

    @inlinable
    public func interpolate(_ t: T) -> T {
        if t <= xVals[0] { return yVals[0] }
        for i in 1 ... n {
            if t <= xVals[i] {
                return (t - xVals[i - 1]) * (yVals[i] - yVals[i - 1]) / (xVals[i] - xVals[i - 1]) + yVals[i - 1]
            }
        }
        return yVals[n]
    }
}
