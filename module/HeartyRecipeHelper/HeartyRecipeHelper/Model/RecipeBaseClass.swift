//
//  RecipeBaseClass.swift
//
//  Created by Intan Nurjanah on 03/06/21
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct RecipeBaseClass: Codable, Hashable {
    
    public static func == (lhs: RecipeBaseClass, rhs: RecipeBaseClass) -> Bool {
        return true
    }
    
    enum CodingKeys: String, CodingKey {
        case ingredients
        case originalURL
        case imageURL
        case steps
        case name
        case time
        case serving
    }

    public var ingredients: [RecipeIngredients]?
    public var originalURL: String?
    public var imageURL: String?
    public var steps: [String]?
    public var name: String?
    public var time: Int?
    public var serving: String?
    public var widgetURL: URL?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ingredients = try container.decodeIfPresent([RecipeIngredients].self, forKey: .ingredients)
        originalURL = try container.decodeIfPresent(String.self, forKey: .originalURL)
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        steps = try container.decodeIfPresent([String].self, forKey: .steps)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        time = try container.decodeIfPresent(Int.self, forKey: .time)
        serving = try container.decodeIfPresent(String.self, forKey: .serving)
        widgetURL = URL(string: "recipe://\((name ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? (name ?? "").filter { $0.isWhitespace })")
    }
    
    public func getTime() -> String {
        var result = ""
        guard let time = time else {
            return ""
        }
        let hour: Int = time / 60
        let min: Int = time % 60
        
        if min > 0 {
            result = "\(min) \(min > 1 ? "mins" : "min")"
        }
        
        guard hour > 0 else {
            return result
        }
        
        return "\(hour) \(hour > 1 ? "hrs" : "hr") " + result
    }

}
