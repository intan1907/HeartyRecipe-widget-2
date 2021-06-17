//
//  HeartyRecipeWidgetView.swift
//  HeartyRecipe
//
//  Created by Intan Nurjanah on 07/06/21.
//

import Foundation
import SwiftUI
import WidgetKit
import HeartyRecipeHelper

struct HeartyRecipeWidgetView: View {
    var recipe: RecipeBaseClass?
    
    @Environment(\.widgetFamily) var family: WidgetFamily

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            HeartyRecipeWidgetSmallView(recipe: recipe)
        case .systemMedium:
            HeartyRecipeWidgetMediumView(recipe: recipe)
        case .systemLarge:
            HeartyRecipeWidgetLargeView(recipe: recipe)
        @unknown default:
            EmptyView()
        }
    }
}

struct HeartyRecipeWidgetSmallView: View {
    var recipe: RecipeBaseClass?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.white)
            VStack(alignment: .leading) {
                Image.loadLocalImage(image: recipe?.imageURL ?? "")
                    .centerCropped()
                    .frame(height: 64)
                    .cornerRadius(10)
                
                Text("\(recipe?.getTime() ?? "") • \(recipe?.serving ?? "1 portion")")
                    .font(.system(size: 10, weight: .regular, design: .default))

                Text(recipe?.name ?? "")
                    .font(.system(size: 12, weight: .semibold, design: .default))
                    .multilineTextAlignment(.leading)
            }
            .padding()
        }
        .widgetURL(recipe?.widgetURL)
    }
}

struct HeartyRecipeWidgetMediumView: View {
    var recipe: RecipeBaseClass?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.white)
            GeometryReader {
                geometry in
                HStack(alignment: .top) {
                    Image.loadLocalImage(image: recipe?.imageURL ?? "")
                        .centerCropped()
                        .frame(width: geometry.size.height)
                        .cornerRadius(10)
                
                    VStack(alignment: .leading) {
                        Text(recipe?.name ?? "")
                            .font(.system(size: 14, weight: .semibold, design: .default))
                            .multilineTextAlignment(.leading)
                        
                        Text("\(recipe?.getTime() ?? "") • \(recipe?.serving ?? "1 portion")")
                            .font(.system(size: 12, weight: .regular, design: .default))
                        
                        let array: [String] = recipe?.ingredients?.map({
                            $0.name ?? ""
                        }) ?? []
                        let joinedString  = array.joined(separator: "; ")
                        Text("\(joinedString)")
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .padding(.top, 1)
                    }
                }
            }
            .padding()
        }
    }
}

struct HeartyRecipeWidgetLargeView: View {
    var recipe: RecipeBaseClass?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.white)
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Text(recipe?.name ?? "")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .multilineTextAlignment(.leading)
                    
                    Image.loadLocalImage(image: recipe?.imageURL ?? "")
                        .centerCropped()
                        .frame(height: geometry.size.width/2)
                        .cornerRadius(10)
                        
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(alignment: .top, spacing: 2) {
                            Text("Ready in: ")
                                .font(.system(size: 12, weight: .semibold, design: .default))
                                .fontWeight(.semibold)
                            Text("\(recipe?.getTime() ?? "30 mins")")
                                .font(.system(size: 12, weight: .regular, design: .default))
                        }
                        HStack(alignment: .top, spacing: 2) {
                            Text("Serves: ")
                                .font(.system(size: 12, weight: .semibold, design: .default))
                                .fontWeight(.semibold)
                            Text("\(recipe?.serving ?? "1 portion")")
                                .font(.system(size: 12, weight: .regular, design: .default))
                        }
                    }

                    // ingredients string
                    let array: [String] = recipe?.ingredients?.map({
                        $0.name ?? ""
                    }) ?? []
                    let ingredients  = array.joined(separator: "; ")
                                        
                    (Text("Ingredients: ").fontWeight(.bold) + Text("\(ingredients)"))
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .padding(.top, 2)
                    
                    // instruction string
                    let steps = (recipe?.steps ?? []).joined(separator: " • ")
                    (Text("Instructions: ").fontWeight(.bold) + Text("\(steps)"))
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .padding(.top, 2)
                }
            }
            .padding()
        }
    }
}


struct HeartyRecipeWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeartyRecipeWidgetSmallView(recipe: recipeData?[7]).previewContext(WidgetPreviewContext(family: .systemSmall))

            HeartyRecipeWidgetMediumView(recipe: recipeData?[3]).previewContext(WidgetPreviewContext(family: .systemMedium))
            
            HeartyRecipeWidgetLargeView(recipe: recipeData?[1]).previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
