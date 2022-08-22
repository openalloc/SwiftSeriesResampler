//
//  AccelLerpResampler.swift
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
import Accelerate

/// A double-precision resampler that employs a linear interpolator from Apple's Accelerate framework.
open class AccelLerpResamplerD: BaseIndiceResampler<Double> {
    override public func resample(_ yVals: [Double]) -> [Double] {
        guard isValid, xVals.count == yVals.count else { return [] }
        return vDSP.linearInterpolate(values: yVals, atIndices: targetIndices)
    }
}

/// A single-precision resampler that employs a linear interpolator from Apple's Accelerate framework.
open class AccelLerpResamplerS: BaseIndiceResampler<Float> {
    override public func resample(_ yVals: [Float]) -> [Float] {
        guard isValid, xVals.count == yVals.count else { return [] }
        return vDSP.linearInterpolate(values: yVals, atIndices: targetIndices)
    }
}
