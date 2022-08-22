//
//  BaseResampler.swift
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

import Foundation

/// BaseResampler (don't use this one directly; use a subclass).
open class BaseResampler<T>
    where T: BinaryFloatingPoint & Strideable, T.Stride == T
{
    public let xVals: [T]
    public let targetCount: Int

    public init?(_ xVals: [T], targetCount: Int) {
        guard xVals.isAscending(), targetCount > 1 else { return nil }
        self.xVals = xVals
        self.targetCount = targetCount
    }

    public lazy var horizontalExtent: T = {
        relativeDistances.last!
    }()
    
    /// xVal distances from first xVal
    public lazy var relativeDistances: [T] = {
        xVals.map { $0 - xVals.first! }
    }()

    public lazy var targetInterval: T = {
        horizontalExtent / T(targetCount - 1)
    }()
    
    public lazy var targetStride: StrideThrough<T> = {
        stride(from: xVals.first!,
               through: xVals.last!,
               by: targetInterval)
    }()
    
    public lazy var targetVals: [T] = {
        Array(targetStride)
    }()
    
    /// Resample the specified values, interpolating them over the target.
    open func resample(_: [T]) -> [T] {
        fatalError("resample() not implemented in base class; use a subclass instead")
    }
}
