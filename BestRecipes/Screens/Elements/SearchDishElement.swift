//
//  SearchDishElement.swift
//  BestRecipes
//
//  Created by Юрий on 04.07.2024.
//

import SwiftUI

struct SearchDishElement: View {
    let rating: Double
    
    @State var dish: DishLightModel
    
    var body: some View {
        ZStack {
            CachedAsyncImage(url: URLManager.shared.createURLForImage(id: dish.id, size: .size480), transaction: .init(animation: .easeInOut(duration: 1))) { imageIn in
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
                
                Text("\(dish.ingredientsCount) Ingredients | \(dish.readyInMinutes) minutes")
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
    SearchDishElement(rating: 5.0, dish: DishLightModel())
}

