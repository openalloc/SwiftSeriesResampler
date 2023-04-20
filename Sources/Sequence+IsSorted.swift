//
// Array+IsSorted.swift
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

// From Wikipedia:
//
// A sequence is said to be monotonically increasing if each term is greater than or equal to the one before it.
//
// If each consecutive term is strictly greater than (>) the previous term then the sequence is called strictly monotonically increasing.

extension Sequence where Element: Comparable {
    func isAscending(strict: Bool = false) -> Bool {
        let tuples = zip(self, dropFirst())
        return strict ? tuples.allSatisfy(<) : tuples.allSatisfy(<=)
    }

    func isDescending(strict: Bool = false) -> Bool {
        let tuples = zip(self, dropFirst())
        return strict ? tuples.allSatisfy(>) : tuples.allSatisfy(>=)
    }
}
