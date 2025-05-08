//
//  ShapesGrid.swift
//  CricutShapesApp
//
//  Created by Michael Thornton on 5/3/25.
//

import SwiftUI
import ShapeKit

struct ShapesGrid: View {
    let allShapes: [ShapeType]
    let onTapShapeAt: (Int) -> Void
    
    init(allShapes: [ShapeType], onTapShapeAt: @escaping (Int) -> Void) {
        self.allShapes = allShapes
        self.onTapShapeAt = onTapShapeAt
    }

    private let columns = Array(repeating: GridItem(.flexible()), count: 3)

    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(allShapes.indices, id: \.self) { i in
                        shapeView(for: allShapes[i])
                            .frame(width: 100, height: 100)
                            .foregroundColor(.brandPrimary)
                            .onTapGesture {
                                onTapShapeAt(i)
                            }
                    }
                    
                    // Anchor to scroll to
                    Color.clear
                        .frame(height: 1)
                        .id("bottom")
                }
                .padding()
            }
            .onChange(of: allShapes.count) {
                withAnimation {
                    scrollProxy.scrollTo("bottom", anchor: .bottom)
                }
            }
        }
    }
    
    @ViewBuilder
    private func shapeView(for shape: ShapeType) -> some View {
        switch shape {
            case .circle: Circle()
            case .square: Rectangle()
            case .triangle: Triangle()
            case .box : boxShape
        }
    }
    
    @ViewBuilder private var boxShape: some View {
        Rectangle()
            .stroke(Color.brandPrimary, lineWidth: 5)
    }
}

// MARK: - Preview

#Preview {
    struct PreviewWrapper: View {
        @State private var shapes: [ShapeType] = [
            .square,
            .box
        ]
        
        var body: some View {
            ShapesGrid(allShapes: shapes) {
                shapes.remove(at: $0)
            }
        }
    }
    
    return PreviewWrapper()
}
