//
//  Data.swift
//  HeartyRecipe
//
//  Created by Intan Nurjanah on 03/06/21.
//

import Foundation

public var recipeData: [RecipeBaseClass]? = loadJsonFromFile()

// load dummy data from json file
func loadJsonFromFile(fileName: String = "Recipes") -> [RecipeBaseClass]? {
    let decoder = JSONDecoder()
    let bundle = Bundle(identifier: "intan3951.HeartyRecipeHelper")
    guard
        let url = bundle?.url(forResource: fileName, withExtension: "json"),
        let data = try? Data(contentsOf: url)
    else { /* Insert error handling here */
        print("file not found atau data nil")
        return []
    }
    
    var result: [RecipeBaseClass] = []
    do {
        result = try decoder.decode([RecipeBaseClass].self, from: data)
    } catch {
        // I find it handy to keep track of why the decoding has failed. E.g.:
        print(error)
        // Insert error handling here
    }
    return result
    
}

public func getRandomRecipe() -> RecipeBaseClass? {
    guard !(recipeData?.isEmpty ?? true) else {
        return nil
    }
    let randomIndex = Int.random(in: 0..<(recipeData?.count ?? 0))
    return recipeData?[randomIndex]
}
