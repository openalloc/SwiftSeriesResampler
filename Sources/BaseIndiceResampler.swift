//
//  BaseIndiceResampler.swift
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

/// A base resampler to be subclassed by resamplers requiring indiced values (don't use this one directly; use a subclass).
open class BaseIndiceResampler<T>: BaseResampler<T>
    where T: BinaryFloatingPoint & Strideable, T.Stride == T
{
    internal var isValid: Bool {
        xVals.count == targetIndices.count
    }

    internal lazy var targetIndiceRange: ClosedRange<T> = {
        0 ... T(targetCount - 1)
    }()

    /// The indices to the output vector.
    internal lazy var targetIndices: [T] = {
        guard let first = relativeDistances.first,
              let last = relativeDistances.last
        else { return [] }
        let minMax = (min: first, max: last)
        let normDistances = relativeDistances.normalize(to: targetIndiceRange, from: minMax) ?? []

        // NOTE the final 'normalized' interval may be slightly less than desired (198.999999 vs 199.0),
        // so coerce all to whole numbers via standard rounding.
        return normDistances.map { $0.rounded() }
    }()
}
