//
//  TrendingNowView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct DishesListView: View {
    
    @ObservedObject var modelData = ModelData()
    @State var dishesList: [DishLightModel]
    @State var textHeader: String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(dishesList, id: \.id) { dish in
                NavigationLink(destination: RecipeDetailView(id: dish.id)) {
                    HStack{
                        ZStack {
                            TrendingDishElement(bigSize: true, dish: dish)
                            VStack {
                                HStack {
                                    RatingElement(bg: true, rating: dish.spoonacularScore)
                                    Spacer()
                                    FavoriteElement(checkFavorite: true)
                                }
                                
                                .padding(.horizontal, 7)
                                Spacer()
                            }
                            .frame(width: 343)
                        }
                        .padding(.vertical, 20)
                        
                    }
                }
            }
            
            Spacer(minLength: 130)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(textHeader)
                    .font(.custom(Font.semiBold, size: 24))
                    .foregroundColor(.black)
            }
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView()
            }
        }
    }
}

#Preview {
    DishesListView(dishesList: [], textHeader: "Trending")
}

