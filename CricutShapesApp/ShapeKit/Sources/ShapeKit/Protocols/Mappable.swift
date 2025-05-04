//
//  Mappable.swift
//  ShapeKit
//
//  Created by Michael Thornton on 5/3/25.
//

public protocol Mappable {
    associatedtype DomainModel
    func toDomain() -> DomainModel
}
