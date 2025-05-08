//
//  ShapeType.swift
//  ShapeKit
//
//  Created by Michael Thornton on 5/3/25.
//
import Foundation

/// Example of implementing Shape
/// public struct Shape {
///     let id = UUID()
///     let shapeType: ShapeType
/// }


public enum ShapeType: String, Codable, CaseIterable, Identifiable, Sendable {
    case circle
    case square
    case triangle
    case box
    
    public var id: String { rawValue }
}
