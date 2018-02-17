// Copyright © 2015 Venture Media Labs.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import Upsurge
import XCTest

class DSPTests: XCTestCase {
    func testConvolution() {
        let actual = convolution([0.0, 1.0, 2.0, 0.0], [0.0, -1.0])
        let expected: ValueArray<Double> = [0.0, -1.0, -2.0]
        XCTAssertEqual(actual, expected)
    }

    func testCorrelation() {
        let actual = correlation([0.0, 1.0, 2.0, 0.0], [0.0, -1.0])
        let expected: ValueArray<Double> = [-1.0, -2.0, 0.0]
        XCTAssertEqual(actual, expected)
    }

    func testAutocorrelation() {
        let actual = autocorrelation([1.0, 1.0], maxLag: 1)
        let expected: ValueArray<Double> = [2.0, 1.0]
        XCTAssertEqual(actual, expected)
    }

    func testFFT() {
        let count = 64
        let frequency = 4.0
        let step = 2.0 * Double.pi / Double(count)
        let x = ValueArray<Double>((0..<count).map({ step * Double($0) * frequency }))
        let fft = FFTDouble(inputLength: x.count)
        let complex = fft.forward(sin(x))
        XCTAssertEqual(complex.count, x.count/2)
    }

    func testMultipleFFTs() {
        let size = 256
        let fft_calculator = FFTFloat(inputLength: size)
        let fft_d = FFTDouble(inputLength: size)

        let x2 = ValueArray<Double>((0 ..< size).map({ sin(0.01 * Double($0)) }))
        let x3 = ValueArray<Float>((0 ..< size).map({ sin(0.01 * Float($0)) }))

        for _ in 0..<10 {
            _ = fft_d.forwardMags(x2)
            _ = fft_calculator.forwardMags(x3)
        }
    }
}
