//
//  ShapeDefinition.swift
//  ShapeKit
//
//  Created by Michael Thornton on 5/3/25.
//

import Foundation

public struct ShapeDefinition: Identifiable, Sendable {
    public let id: UUID
    public let name: String
    public let drawPath: ShapeType
    
    public init(id: UUID = UUID(), name: String, drawPath: ShapeType) {
        self.id = id
        self.name = name
        self.drawPath = drawPath
    }
}
