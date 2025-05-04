//
//  GridEditor.swift
//  CricutShapesApp
//
//  Created by Michael Thornton on 5/4/25.
//

import SwiftUI
import ShapeKit

struct GridEditor<Footer: View>: View {
    private let allShapes: [ShapeType]
    private var footer: () -> Footer
    
    init(allShapes: [ShapeType], @ViewBuilder footer: @escaping () -> Footer) {
        self.allShapes = allShapes
        self.footer = footer
    }

    var body: some View {
        VStack {
            ShapesGrid(allShapes: allShapes)
            
            Spacer()
            
            footer()
        }
    }
}

// MARK: - Preview

#Preview {
    struct PreviewWrapper: View {
        @State private var path = NavigationPath()
        let mockDefinitions = [
            ShapeDefinition(id: UUID(), name: "Circle", drawPath: .circle),
            ShapeDefinition(id: UUID(), name: "Square", drawPath: .square),
            ShapeDefinition(id: UUID(), name: "Triangle", drawPath: .triangle)
        ]
        
        @State private var mockShapes: [ShapeType] = [
            .square,
            .circle,
            .triangle,
            .triangle,
            .square,
            .circle,
            .square
        ]
        
        var body: some View {
            NavigationStack(path: $path) {
                GridEditor(allShapes: mockShapes) {
                    addShapeButtons
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Clear All") {
                            mockShapes.removeAll()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Edit Circles") {
                            path.append("circleEditor")
                        }
                    }
                }
                .navigationDestination(for: String.self) { destination in
                    if destination == "circleEditor" {
                        GridEditor(allShapes: mockShapes.filter({ $0 == .circle })) {
                            circleEditorButtons
                        }
                        .navigationBarBackButtonHidden(true)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button {
                                    path.removeLast()
                                } label: {
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        @ViewBuilder
        private var addShapeButtons: some View {
            HStack(spacing: 0) {
                ForEach(mockDefinitions) { definition in
                    Button(definition.name) {
                        mockShapes.append(definition.drawPath)
                    }
                    .buttonStyle(.borderless)
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            }
        }
        
        @ViewBuilder var circleEditorButtons: some View {
            HStack(spacing: 0) {
                Group {
                    Button("Delete All") {
                        mockShapes.removeAll { $0 == .circle }
                    }
                    
                    Button("Add") {
                        mockShapes.append(.circle)
                    }
                    
                    Button("Remove") {
                        guard let lastCircleIndex = mockShapes.lastIndex(where: { $0 == .circle }) else { return }
                        mockShapes.remove(at: lastCircleIndex)
                    }
                }
                .buttonStyle(.borderless)
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
    
    return PreviewWrapper()
}
