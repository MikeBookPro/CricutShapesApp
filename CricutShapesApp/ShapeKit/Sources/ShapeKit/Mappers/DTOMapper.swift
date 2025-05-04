//
//  DTOMapper.swift
//  ShapeKit
//
//  Created by Michael Thornton on 5/3/25.
//

public enum DTOMapper {
    
    /// Maps an array of DTOs conforming to `Mappable` into their domain models.
    public static func map<T: Mappable>(_ dtos: [T]) -> [T.DomainModel] {
        dtos.map { $0.toDomain() }
    }
}
