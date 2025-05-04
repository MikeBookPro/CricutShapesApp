
//
//  ShapesService.swift
//  ShapeKit
//
//  Created by Michael Thornton on 5/3/25.
//

import Foundation

// MARK: - Protocol

public protocol ShapesServiceRepresentable {
    func fetchShapeDefinitions() async throws -> [ShapeDefinition]
}

// MARK: Protocol

public struct ShapesService: ShapesServiceRepresentable {
    public init() {}

    public func fetchShapeDefinitions() async throws -> [ShapeDefinition] {
        guard let url = URL(string: "https://staticcontent.cricut.com/static/test/shapes_001.json") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(ShapesDefinitionResponseDTO.self, from: data)
        return DTOMapper.map(decoded.buttons)
    }
}
