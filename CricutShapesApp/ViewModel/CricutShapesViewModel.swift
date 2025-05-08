//
//  CricutShapesViewModel.swift
//  CricutShapesApp
//
//  Created by Michael Thornton on 5/3/25.
//

import SwiftUI
import ShapeKit

public final class CricutShapesViewModel<ShapeService: ShapesServiceRepresentable>: ObservableObject {
    public enum ButtonTarget {
        case add(ShapeType)
        case clearAll
        case removeAll(ShapeType)
        case removeLast(ShapeType)
        case showCircleEditor
        case dismissEditor
        case shapeAt(index: Int)
    }
    
    @Published var navigationPath = NavigationPath()
    @Published var shapeDefinitions: [ShapeDefinition] = []
    @Published var shapes: [ShapeType] = []
    
    private let shapeService: ShapeService
    
    init(mockShapeService: ShapeService) {
        self.shapeService = mockShapeService
    }
    
    public init() where ShapeService == ShapeKit.ShapesService {
        self.shapeService = .init()
    }
    
    public func userDidTap(_ target: ButtonTarget) {
        switch target {
            case .add(let shapeType):
                shapes.append(shapeType)
                
            case .clearAll:
                shapes.removeAll()
                
            case .removeAll(let shapeType):
                shapes.removeAll { $0 == shapeType }
                
            case .removeLast(let shapeType):
                guard let lastShapeIndex = shapes.lastIndex(where: { $0 == shapeType }) else { return }
                shapes.remove(at: lastShapeIndex)
                
            case .showCircleEditor:
                navigationPath.append("circleEditor")
                
            case .dismissEditor:
                navigationPath.removeLast()
                
            case .shapeAt(let index):
                shapes.remove(at: index)
        }
    }
    
    public func circleEditor(isTarget destination: String) -> Bool {
        destination == "circleEditor"
    }
    
    public func fetchShapeDefinitions() async {
        do {
            let shapes = try await shapeService.fetchShapeDefinitions()
            await MainActor.run {
                self.shapeDefinitions = shapes
            }
        } catch {
            print("Failed to fetch shape definitions: \(error)")
        }
        
    }
}
