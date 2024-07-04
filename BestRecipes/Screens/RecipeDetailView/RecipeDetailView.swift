//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct RecipeDetailView: View {

    @ObservedObject var modelData = ModelData()
    @Binding var dish: RecipeDetails

    var body: some View {
        VStack {
            // title
            HStack {
                Text("How to make \(dish.title)")
                    .font(.custom(Font.semiBold, size: 30))
            }

            // dish image
            HStack {
                AsyncImage(url: URL(string: dish.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }

            // raiting
            HStack {
                Text("300 Reviews")
            }

            // instructions
            VStack {
                Text("Instructions")
                
            }
            Spacer()

        }
        .padding()

    }
}


#Preview {
    RecipeDetailView(dish: .constant(RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 0, healthScore: 2, creditsText: "", sourceName: "", pricePerServing: 0.1, extendedIngredients: [], id: 2, title: "Carrots, Cauliflower And Anchovies", readyInMinutes: 2, servings: 1, sourceURL: "", image: "https://img.spoonacular.com/recipes/3-556x370.jpg", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 0.2)))
}
