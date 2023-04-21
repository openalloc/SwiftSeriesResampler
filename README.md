# SwiftSeriesResampler

Transform a series of coordinate values into a new series with uniform intervals.

Why _SwiftSeriesResampler_? A typical use is to prepare a set of coordinates for plotting in a chart, where that chart requires uniform intervals along the x-axis, such as in a time series.

Available as an open source Swift library to be incorporated in other apps.

_SwiftSeriesResampler_ is part of the [OpenAlloc](https://github.com/openalloc) family of open source Swift software tools.

## SeriesResampler

This example shows the resampling of market value data in a time series from 5 *non-uniform* intervals to 8 *uniform intervals* in the target, as depicted in the charts.

<img src="https://github.com/openalloc/SwiftSeriesResampler/blob/main/Images/example.png" width="1149" height="397"/>

```swift
let df = ISO8601DateFormatter()
let d1 = df.date(from: "2020-06-01T10:00:00Z")!
let d2 = df.date(from: "2020-06-20T08:00:00Z")!
let d3 = df.date(from: "2020-06-28T09:00:00Z")!
let d4 = df.date(from: "2020-07-18T11:00:00Z")!
let d5 = df.date(from: "2020-07-30T13:00:00Z")!

let intervals = [d1, d2, d3, d4, d5].map { $0.timeIntervalSinceReferenceDate }
let marketValues = [1300.0, 1600.0, 1200.0, 800.0, 1500.0]

let s = LerpResampler(intervals, targetCount: 8)!
let targetMVs = s.resample(marketValues)

for pair in zip(s.targetVals, targetMVs) {
    let d = Date(timeIntervalSinceReferenceDate: pair.0)
    print(String(format: "%@: $%5.0f", df.string(from: d), pair.1))
}

=>
 "2020-06-01T10:00:00Z: $ 1300"
 "2020-06-09T20:42:51Z: $ 1434"
 "2020-06-18T07:25:42Z: $ 1568"
 "2020-06-26T18:08:34Z: $ 1281"
 "2020-07-05T04:51:25Z: $ 1064"
 "2020-07-13T15:34:17Z: $  896"
 "2020-07-22T02:17:08Z: $ 1011"
 "2020-07-30T13:00:00Z: $ 1500"
```

Code for the `AccelLerpResamplerD` isn't shown, but is easily reproduced by replacing `LerpResampler` with it.

## Resamplers

Two resamplers are currently offered, both based on linear interpolation technique.

As depicted above, the behavior between the two resamplers differs, as they handle the interpolation differently.

### LerpResampler

A basic resampler that employs a pure-Swift linear interpolator (aka lerp).

### AccelLerpResampler

Actually two resamplers that employ a linear interpolator from Apple's Accelerate framework.

The single-precision version, `AccelLerpResamplerS`, is for use with `Float` and similar data types.

The double-precision version, `AccelLerpResamplerD`, is for use with `Double` and similar data types. Notably with `TimeInterval` which is handy for charting time series.

## Base Instance Properties and Methods

All resamplers are derived from the `BaseResampler` class, which offers the following public properties and methods. 

Derived resamplers may offer additional public properties and methods.

#### Initializer

- `init?(_ xVals: [T], targetCount: Int)` - create a new resampler instance

Where `T` is your `BinaryFloatingPoint` data type. Note that some resamplers have fixed types.

Initialization is conditional, returning `nil` if the parameters are nonsensical, such as if the `xVals` are not in ascending order.

The initialization values are also available as properties:

- `let xVals: [T]` - the original coordinates along the x-axis. They do not need to be uniform in spacing.

- `let targetCount: Int` - the number of uniformly-spaced coordinates along the x-axis to target in the resampling.

#### Instance Properties

Computed properties are lazy, meaning that they are only calculated when first needed.

- `var horizontalExtent: T` - The distance separating the first and last `xVal`.

- `var relativeDistances: [T]` - `xVal` distances from first `xVal`. The first is `0`. The last is equal to `horizontalExtent`.

- `var targetInterval: T` - The width of each interval between the resampled coordinates.

- `var targetStride: [T]` - The resampled x-axis coordinates, as a stride object. They are uniformly-spaced.

- `var targetVals: [T]` - The resampled x-axis coordinates, as an array object. They are uniformly-spaced.

#### Instance Methods

- `func resample(yVals: [T]) -> [T]` - Resample the specified array of y-coordinate values for the original `xVals` provided when initializing the resampler. Returns `targetCount` resampled y-coordinate values.

## See Also

This library is a member of the _OpenAlloc Project_.

* [_OpenAlloc_](https://openalloc.github.io) - product website for all the _OpenAlloc_ apps and libraries
* [_OpenAlloc Project_](https://github.com/openalloc) - Github site for the development project, including full source code

## License

Copyright 2021, 2022 OpenAlloc LLC

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

## Contributing

Other contributions are welcome too. You are encouraged to submit pull requests to fix bugs, improve documentation, or offer new features.

The pull request need not be a production-ready feature or fix. It can be a draft of proposed changes, or simply a test to show that expected behavior is buggy. Discussion on the pull request can proceed from there.

Contributions should ultimately have adequate test coverage. See tests for current entities to see what coverage is expected.
