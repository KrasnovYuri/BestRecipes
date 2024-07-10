//
//  RecentListView.swift
//  BestRecipes
//
//  Created by Evgeniy K on 10.07.2024.
//

import SwiftUI

struct RecentListView: View {

    @ObservedObject var modelData = ModelData()
    @State var textHeader: String

        var body: some View {
            ScrollView(showsIndicators: false) {
                ForEach(modelData.recentDishes, id: \.id) { dish in
                    NavigationLink(destination: RecipeDetailView(id: dish.id)) {
                        HStack {
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
    RecentListView(textHeader: "Recent")
}
