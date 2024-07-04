//
//  TrendingDishElement.swift
//  BestRecipes
//
//  Created by Руслан on 04.07.2024.
//

import SwiftUI

struct TrendingDishElement: View {
    @State var bigSize: Bool
    @State var dish: RecipeDetails
    var body: some View {
        VStack {
            ZStack{
                AsyncImage(url: URLManager.shared.createURLForImage(id: dish.id, size: .size480), transaction: .init(animation: .easeInOut(duration: 1))) { imageIn in
                    switch imageIn {
                    case .success(let imageIn):
                        imageIn.resizable()
                            .scaledToFill()
                            .frame(width: bigSize ? 343 : 280, height: 180)
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
                .clipShape(RoundedRectangle(cornerRadius: 10))
                if bigSize {
                    VStack{
                        Spacer()
                        HStack {
                            Spacer()
                            ZStack() {
                                RoundedRectangle(cornerRadius: 7)
                                    .foregroundStyle(.ultraThinMaterial)
                                    .opacity(0.8)
                                    .frame(width: 41, height: 25)
                                
                                Text("\(dish.readyInMinutes):00")
                                    .font(.custom(Font.medium, size: 13))
                                    .foregroundStyle(.brBlack.opacity(0.9))
                                
                            }
                            .padding(8)
                        }
                    }
                }
            }
            .frame(width: bigSize ? 343 : 280, height: 180)
            Text("How to \(dish.title)")
                .lineLimit(1)
                .font(.custom(Font.medium, size: 22))
            HStack {
                AsyncImage(url: URLManager.shared.createURLForImage(id: dish.id, size: .size90), transaction: .init(animation: .easeInOut)) { imageIn in
                    switch imageIn {
                    case.success(let imageIn):
                        imageIn.resizable()
                            .scaledToFill()
                    default:
                        ZStack {
                            Circle()
                            Image(systemName: "person")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    
                    
                    Text("By \(dish.creditsText)")
                        .font(.custom(Font.light, size: 17))
                        .foregroundStyle(.brGray)
                        .lineLimit(1)
                    Spacer()
                }
                .offset(y: -13)
                
            }
            .frame(width: bigSize ? 343 : 280, height: 254)
        }
    }
    

#Preview {
    TrendingDishElement(bigSize: false, dish: (RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 0, healthScore: 2, creditsText: "Afrolems", sourceName: "", pricePerServing: 0.1, extendedIngredients: [], id: 21232, title: "Almond Bark – Renee Charles of Four Weddings Canada- Celebrity Chef of the week", readyInMinutes: 12, servings: 1, sourceURL: "", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 0.2)))
}

