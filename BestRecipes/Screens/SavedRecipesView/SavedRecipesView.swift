//
//  SavedRecipesView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct SavedRecipesView: View {
    @StateObject var modelData: ModelData = ModelData()
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Text("Saved recipes")
                        .lineLimit(2)
                        .font(.custom(Font.bold, size: 24))
                    Spacer()
                }
                ScrollView(.vertical) {
                    ForEach(modelData.savedDishes, id: \.id ) { dish in
                        NavigationLink {
                            Text("")
                        } label: {
                            ZStack {
                                TrendingDishElement(bigSize: true, dish: dish)
                                VStack {
                                    HStack {
                                        RatingElement(bg: true, rating: dish.spoonacularScore)
                                        Spacer()
                                        FavoriteElement(checkFavorite: true)
                                    }
                                    .padding(.horizontal, 15)
                                    .padding(5)
                                    Spacer()
                                }
                            }
                        }

                        
                    }
                }
            }
            .padding(10)
        }
    }
}

#Preview {
    SavedRecipesView()
}
