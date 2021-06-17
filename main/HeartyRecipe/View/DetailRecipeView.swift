//
//  DetailRecipeView.swift
//  HeartyRecipe
//
//  Created by Intan Nurjanah on 03/06/21.
//

import SwiftUI
import HeartyRecipeHelper

struct DetailRecipeView: View {
    var recipe: RecipeBaseClass?
    
    let screenWidth = UIScreen.main.bounds.width
    let height = (UIScreen.main.bounds.width/3)*2
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("ic_back") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Image.loadLocalImage(image: recipe?.imageURL ?? "")
                    .centerCropped()
                    .frame(width: screenWidth, height: height)
                    
                
                Text("\(recipe?.name ?? "")")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .top, spacing: 4) {
                        Text("Ready in: ")
                            .font(.system(size: 14, weight: .semibold, design: .default))
                            .fontWeight(.semibold)
                        Text("\(recipe?.getTime() ?? "30 mins")")
                            .font(.system(size: 14, weight: .regular, design: .default))
                    }
                    HStack(alignment: .top, spacing: 4) {
                        Text("Serves: ")
                            .font(.system(size: 14, weight: .semibold, design: .default))
                            .fontWeight(.semibold)
                        Text("\(recipe?.serving ?? "1 portion")")
                            .font(.system(size: 14, weight: .regular, design: .default))
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 4, trailing: 16))
                
                Text("Ingredients:")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 2, trailing: 16))
                
                ForEach(0..<(recipe?.ingredients?.count ?? 0)) {
                    i in
                    let ingredient = recipe?.ingredients?[i]
                    
                    Text("\(ingredient?.quantity ?? "")")
                        .font(.system(size: 14, weight: .semibold, design: .default)) +
                    Text("\(ingredient?.name ?? "")")
                        .font(.system(size: 14, weight: .regular, design: .default))
                    
                }
                .padding(.horizontal)
                
                Text("Instruction:")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 2, trailing: 16))
                
                ForEach(0..<(recipe?.steps?.count ?? 0)) {
                    i in
                    let step = recipe?.steps?[i]
                    HStack(alignment: .top, spacing: 4) {
                        Text("\(i+1). ")
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .frame(width: 24, alignment: .topTrailing)
                        Text("\(step ?? "")")
                            .font(.system(size: 14, weight: .regular, design: .default))
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 32)
        }
        .navigationBarTitle("Detail Recipe", displayMode: .inline)
        // change back button item
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        // change status bar style
        .onAppear {
            UIApplication.setStatusBarStyle(.darkContent)
        }
    }
}

struct DetailRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        DetailRecipeView(recipe: recipeData?[6])
    }
}
