//
//  Codable-Double.swift
//  Upsurge
//
//  Created by Timothy Kautz on 9/29/17.
//  Copyright © 2017 Venture Media Labs. All rights reserved.
//

import Foundation

extension Double {
    public typealias ValueArray = Upsurge.ValueArray<Double>
    public typealias Matrix = Upsurge.Matrix<Double>
    public typealias Array = Swift.Array<Double>

    public struct BoxedValueArray: Codable, Equatable {
        
        public static func ==(
            lhs: Double.BoxedValueArray,
            rhs: Double.BoxedValueArray)
            -> Bool
        {
            return lhs.array == rhs.array
        }
        
        public let array: ValueArray
        
        public enum CodingKeys: String, CodingKey {
            case elements
        }
        
        public init(valueArray: ValueArray) {
            self.array = valueArray
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            let elements = try values.decode(Array.self, forKey: .elements)
            self.array = ValueArray(elements)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let array: Array = Array(self.array)
            try container.encode(array, forKey: .elements)
        }
    }
    
    public struct BoxedMatrix: Codable, Equatable {
        
        public static func ==(
            lhs: Double.BoxedMatrix,
            rhs: Double.BoxedMatrix)
            -> Bool
        {
            return lhs.matrix == rhs.matrix
        }
        
        public let matrix: Matrix
        
        public enum CodingKeys: String, CodingKey {
            case rows
            case columns
            case elements
        }
        
        public init(matrix: Matrix) {
            self.matrix = matrix
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            let elements = try values.decode(Array.self, forKey: .elements)
            let rows = try values.decode(Int.self, forKey: .rows)
            let columns = try values.decode(Int.self, forKey: .columns)
            self.matrix = Matrix(
                rows: rows,
                columns: columns,
                elements: elements)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let array: Array = Array(self.matrix.elements)
            try container.encode(matrix.rows, forKey: .rows)
            try container.encode(matrix.columns, forKey: .columns)
            try container.encode(array, forKey: .elements)
        }
    }
}
