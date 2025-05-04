//
//  ShapeType.swift
//  ShapeKit
//
//  Created by Michael Thornton on 5/3/25.
//

public enum ShapeType: String, Codable, CaseIterable, Identifiable, Sendable {
    case circle
    case square
    case triangle
    
    public var id: String { rawValue }
}
