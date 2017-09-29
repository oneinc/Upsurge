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

@testable import Upsurge
import XCTest

class ComplexTests: XCTestCase {
    let n = 10000

    func textAddComplex() {
        let a: ComplexArray = [Complex(real: 1, imag: 1), Complex(real: 2, imag: 0)]
        let b: ComplexArray = [Complex(real: 2, imag: 2), Complex(real: 1, imag: 3)]
        let r = a + b
        for i in r.startIndex..<r.endIndex {
            XCTAssertEqual(r[i], Complex(real: 3, imag: 3))
        }
    }

    func textScaleComplex() {
        var a: ComplexArray = [Complex(real: 1, imag: 1), Complex(real: 2, imag: 0)]
        a *= 2

        XCTAssertEqual(a[0].real, 2.0)
        XCTAssertEqual(a[0].imag, 2.0)
        XCTAssertEqual(a[1].real, 4.0)
        XCTAssertEqual(a[1].imag, 0.0)
    }

    func testSumComplex() {
        var array: [Complex<Double>] = []
        for _ in 0..<n {
            array.append(Complex(
                real: Double(arc4random()) - Double(UInt32.max)/2,
                imag: Double(arc4random()) - Double(UInt32.max)/2))
        }
        let values = ComplexArray<Double>(array)
        
        var expected = Complex<Double>()
        for i in 0..<values.count {
            expected.real += values[i].real
            expected.imag += values[i].imag
        }

        var actual = Complex<Double>()
        self.measure {
            actual = sum(values)
        }

        XCTAssertEqual(actual.real, expected.real, accuracy: 0.0001)
        XCTAssertEqual(actual.imag, expected.imag, accuracy: 0.0001)
    }

}
