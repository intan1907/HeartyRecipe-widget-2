//
//  RecipeRow.swift
//  HeartyRecipe
//
//  Created by Intan Nurjanah on 03/06/21.
//

import SwiftUI
import HeartyRecipeHelper

struct RecipeRow: View {
    var recipe: RecipeBaseClass?
    
    var body: some View {
        HStack(alignment: .top) {
            Image.loadLocalImage(image: recipe?.imageURL ?? "")
                .centerCropped()
                .frame(width: 64, height: 48)
            VStack(alignment: .leading) {
                Text(recipe?.name ?? "")
                    .font(.system(size: 14, weight: .semibold, design: .default))
                    .padding(.bottom, 1)
                Text("Ready in: \(recipe?.getTime() ?? "30 mins")")
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .foregroundColor(Color.gray)
                Text("Serves: \(recipe?.serving ?? "1 portion")")
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe: recipeData?[0]).previewLayout(.fixed(width: 300, height: 64))
    }
}
