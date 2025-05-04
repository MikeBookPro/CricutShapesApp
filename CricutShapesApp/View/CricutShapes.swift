//
//  CricutShapes.swift
//  CricutShapesApp
//
//  Created by Michael Thornton on 5/4/25.
//

import SwiftUI
import ShapeKit

struct CricutShapes<ShapeService: ShapesServiceRepresentable>: View {
    @StateObject var viewModel: CricutShapesViewModel<ShapeService>
    
    init() where ShapeService == ShapeKit.ShapesService {
        self._viewModel = .init(wrappedValue: CricutShapesViewModel<ShapesService>())
    }
    
    fileprivate init (_ shapeService: ShapeService) {
        self._viewModel = .init(wrappedValue: CricutShapesViewModel<ShapeService>(mockShapeService: shapeService))
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            GridEditor(allShapes: viewModel.shapes) {
                addShapeButtons
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear All") {
                        viewModel.userDidTap(.clearAll)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit Circles") {
                        viewModel.userDidTap(.showCircleEditor)
                    }
                }
            }
            .navigationDestination(for: String.self) { destination in
                if viewModel.circleEditor(isTarget: destination) {
                    GridEditor(allShapes: viewModel.shapes.filter({ $0 == .circle })) {
                        circleEditorButtons
                    }
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                viewModel.userDidTap(.dismissEditor)
                            } label: {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }
                    }
                }
            }
            .task {
                await viewModel.fetchShapeDefinitions()
            }
        }
    }
    
    @ViewBuilder
    private var addShapeButtons: some View {
        HStack(spacing: 0) {
            ForEach(viewModel.shapeDefinitions) { definition in
                Button(definition.name) {
                    viewModel.userDidTap(.add(definition.drawPath))
                }
                .buttonStyle(.borderless)
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
    
    @ViewBuilder
    private var circleEditorButtons: some View {
        HStack(spacing: 0) {
            Group {
                Button("Delete All") {
                    viewModel.userDidTap(.removeAll(.circle))
                }
                
                Button("Add") {
                    viewModel.userDidTap(.add(.circle))
                }
                
                Button("Remove") {
                    viewModel.userDidTap(.removeLast(.circle))
                }
            }
            .buttonStyle(.borderless)
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

// MARK: - Preview

#Preview {
    struct PreviewWrapper: View {
        private struct MockShapeService: ShapesServiceRepresentable {
            func fetchShapeDefinitions() async throws -> [ShapeKit.ShapeDefinition] {
                return [
                    .init(name: "Circle", drawPath: .circle),
                    .init(name: "Square", drawPath: .square),
                    .init(name: "Triangle", drawPath: .triangle)
                ]
            }
        }
        
        var body: some View {
            CricutShapes(MockShapeService())
        }
    }
    
    return PreviewWrapper()
}
