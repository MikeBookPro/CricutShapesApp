//
//  CricutShapesViewModelTests.swift
//  CricutShapesAppTests
//
//  Created by Michael Thornton on 5/9/25.
//

import Testing
@testable import CricutShapesApp

struct CricutShapesViewModelTests {

    @Test func addsCircleOnAddCircleButtonTap() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        var viewModel = CricutShapesViewModel()
        viewModel.userDidTap(.add(.circle))
        #expect(viewModel.shapes.count == 1)
        #expect(viewModel.shapes.first == .circle)
        
    }
    
    @Test func removeCircleOnAddCircleButtonTap() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        var viewModel = CricutShapesViewModel()
        viewModel.shapes += [.circle, .triangle, .square]
        viewModel.userDidTap(.removeAll(.circle))
        #expect(viewModel.shapes.count == 2)
        #expect(viewModel.shapes == [.triangle, .square])
    }
    
//    test clear all
    
//    test editCircles
    
//    test circle | square | triagle
    

}
