//
//  TrendingNowView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct TrendingNowView: View {
    @StateObject var modelData: ModelData
    
    var body: some View {
        ScrollView {
                ForEach(modelData.trendingDishes, id: \.id) { dish in
                    NavigationLink(destination: RecipeDetailView(dish: dish)) {
                        HStack{
                            ZStack {
                                TrendingDishElement(bigSize: true, dish: dish)
                                VStack {
                                    HStack {
                                        RatingElement(bg: true, rating: dish.spoonacularScore)
                                        Spacer()
                                        Button {
                                            
                                        } label: {
                                            FavoriteElement(checkFavorite: true)
                                        }
                                    }
                                    .padding(10)
                                    Spacer()
                                }
                            }
                            .padding(.leading, 20)
                            
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Trending now")
                            .font(.custom(Font.semiBold, size: 24))
                            .foregroundColor(.black)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        BackButton()
                    }
                }
            }
    }
}

#Preview {
    TrendingNowView(modelData: ModelData())
}

