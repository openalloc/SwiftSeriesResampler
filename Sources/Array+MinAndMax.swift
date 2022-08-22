//
//  Array+MinAndMax.swift
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

extension Array where Element: Comparable {
    var minAndMax: (min: Element, max: Element)? {
        guard let firstVal = first else { return nil }
        var lowest = firstVal
        var highest = firstVal
        for value in self[1 ..< count] {
            if value < lowest {
                lowest = value
            } else if value > highest {
                highest = value
            }
        }
        return (lowest, highest)
    }
}
