//
//  LerpResampler.swift
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

/// A basic resampler that employs a pure-Swift linear interpolator (aka lerp).
open class LerpResampler<T>: BaseResampler<T>
    where T: BinaryFloatingPoint & Strideable, T.Stride == T
{
    override public func resample(_ yVals: [T]) -> [T] {
        guard xVals.count == yVals.count else { return [] }
        let lerp = LinearInterpolator(xVals: xVals, yVals: yVals)
        return targetStride.map { lerp.interpolate($0) }
    }
}
