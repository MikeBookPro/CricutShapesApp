//
//  ShapeDefinitionDTO.swift
//  ShapeKit
//
//  Created by Michael Thornton on 5/3/25.
//

import Foundation

struct ShapeDefinitionDTO: Codable, Mappable {
    public let name: String
    public let drawPath: ShapeType

    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
    }
    
    init(name: String, drawPath: ShapeType) {
        self.name = name
        self.drawPath = drawPath
    }
    
    // MARK: Mappable

    func toDomain() -> ShapeDefinition {
        ShapeDefinition(id: UUID(), name: name, drawPath: drawPath)
    }
}
