//
//  Array+Extension.swift
//  CricutShapesApp
//
//  Created by Michael Thornton on 5/9/25.
//

extension Array where Element: Equatable {
    /// Returns the index of the nth occurrence of `element`
    func indexOfNth(_ element: Element, occurrence n: Int) -> Int? {
        var count = 0
        for (i, el) in self.enumerated() {
            if el == element {
                if count == n { return i }
                count += 1
            }
        }
        return nil
    }
}
