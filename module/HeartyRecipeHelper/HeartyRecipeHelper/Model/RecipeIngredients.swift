//
//  RecipeIngredients.swift
//
//  Created by Intan Nurjanah on 03/06/21
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct RecipeIngredients: Codable, Hashable {
    
    public static func == (lhs: RecipeIngredients, rhs: RecipeIngredients) -> Bool {
        return true
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case quantity
    }
    
    public var name: String?
    public var type: String?
    public var quantity: String?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        quantity = try container.decodeIfPresent(String.self, forKey: .quantity)
    }

}
