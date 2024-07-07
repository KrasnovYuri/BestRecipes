//
//  SearchDishElement.swift
//  BestRecipes
//
//  Created by Юрий on 04.07.2024.
//

import SwiftUI

struct SearchDishElement: View {
    let rating: Double
    
    @State var dish: RecipeDetails
    
    var body: some View {
        ZStack {
            AsyncImage(url: URLManager.shared.createURLForImage(id: dish.id, size: .size480), transaction: .init(animation: .easeInOut(duration: 1))) { imageIn in
                switch imageIn {
                case .success(let imageIn):
                    imageIn.resizable()
                        .scaledToFill()
                        .frame(width: 343, height: 200)
                default:
                    ZStack {
                        Color(.white)
                        Image(systemName: "timer")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gray)
                            .frame(width: 50)
                    }
                }
            }
            .frame(width: 343, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack {
                HStack {
                    RatingElement(bg: true, rating: dish.spoonacularScore)
                        .padding(15)
                    Spacer()
                }
                Spacer()
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(dish.title)
                    .font(.custom(Font.bold, size: 16))
                    .shadow(radius: 10)
                    .multilineTextAlignment(.leading)
                    .frame(width: 320, alignment: .bottomLeading)
                
                Text("\(dish.extendedIngredients.count) Ingredients | \(dish.readyInMinutes) minutes")
                    .font(.custom(Font.medium, size: 14))
                    .shadow(radius: 10)
                
            }
            .foregroundColor(.white)
            .offset(x: -5, y: 50)
        }
        .frame(width: 343, height: 200)
    }
}

#Preview {
    SearchDishElement(rating: 5.0, dish: (RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 0, healthScore: 2, creditsText: "Afrolems", sourceName: "", pricePerServing: 0.1, extendedIngredients: [], id: 21232, title: "Almond Bark – Renee Charles of Four Weddings Canada- Celebrity Chef of the week", readyInMinutes: 12, servings: 1, sourceURL: "", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 100.2)))
}

