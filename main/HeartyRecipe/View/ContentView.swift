//
//  ContentView.swift
//  HeartyRecipe
//
//  Created by Intan Nurjanah on 03/06/21.
//

import SwiftUI
import HeartyRecipeHelper

struct ContentView: View {
    let screenWidth = UIScreen.main.bounds.width
    let height = (UIScreen.main.bounds.width/3)*2
    
    @State private var selectedItem: String?
    @State private var listViewId = UUID()
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ZStack(alignment: .top) {
                    Image("banner")
                        .centerCropped()
                    Image("topGradient")
                        .resizable()
                    
                    VStack(alignment: .leading, spacing: 0, content: {
                        HStack {
                            Text("Let's cook!")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(EdgeInsets(top: 40, leading: 16, bottom: 8, trailing: 16))
                            Spacer()
                        }
                        
                        Text("Energize with these healthy and hearty recipes")
                            .font(.body)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    })
                }
                .frame(width: screenWidth, height: height)
                
                Text("Weekly Recipes")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)
                
                List {
                    ForEach(0..<(recipeData?.count ?? 0)) { i in
                        NavigationLink(
                            destination: DetailRecipeView(recipe: recipeData?[i]),
                            tag: "row \(i)",
                            selection: $selectedItem
                        ) {
                            RecipeRow(recipe: recipeData?[i])
                        }
                    }
                }
                .listStyle(PlainListStyle())
                // this is for refreshing the selected item,
                // there is still a bug in list of SwiftUI that makes the higlighted item still appear
                // my work-around is refreshing the List by changing the id
                .id(listViewId)
                .onAppear {
                    if selectedItem != nil {
                        selectedItem = nil
                        listViewId = UUID()
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .onAppear { UIApplication.setStatusBarStyle(.lightContent)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
