//
//  CuisineListView.swift
//  BestRecipes
//
//  Created by Руслан on 09.07.2024.
//

import SwiftUI

struct CuisineListView: View {
    @StateObject var modelData: ModelData
    @State var cuisine: String
    @State var dishesList: [DishLightModel] = []
    let service = NetworkServiceAA()
    
    var body: some View {
        VStack {
            ScrollView (.vertical, showsIndicators: false ) {
                ForEach(dishesList, id: \.id) { dish in
                    NavigationLink(destination: RecipeDetailView(modelData: modelData, disappearIsOn: false, id: dish.id)) {
                        HStack {
                            ZStack {
                                TrendingDishElement(bigSize: true, dish: dish)
                                VStack {
                                    HStack {
                                        RatingElement(bg: true, rating: dish.spoonacularScore)
                                        Spacer()
                                        FavoriteElement(checkFavorite: modelData.checkFavorite(id: dish.id))
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
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(cuisine.capitalized)
                        .font(.custom(Font.semiBold, size: 24))
                        .foregroundColor(.black)
                }
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonView()
                }
            }
            .onAppear {
                Task {
                    do {
                        dishesList = try await service.getDishByCuisine(cuisine: cuisine, numberLimit: 10)
                    } catch {
                        print("CuisineListView error")
                    }
                }
            }
        }
    }
}

#Preview {
    CuisineListView(modelData: ModelData(), cuisine: "African")
}
