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

    private let columns = Array(repeating: GridItem(.flexible()), count: 3)

    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(allShapes.indices, id: \.self) { i in
                        shapeView(for: allShapes[i])
                            .frame(width: 100, height: 100)
                            .foregroundColor(.brandPrimary)
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
        }
    }
}

// MARK: - Preview

#Preview {
    ShapesGrid(
        allShapes: [
            .square,
            .circle,
            .triangle,
            .triangle,
            .square,
            .circle,
            .square
        ]
    )
}
