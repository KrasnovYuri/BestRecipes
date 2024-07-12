//
//  RandomRecipeView.swift
//  BestRecipes
//
//  Created by Evgeniy K on 12.07.2024.
//

import SwiftUI

struct RandomRecipeView: View {

    @ObservedObject var modelData: ModelData
    @State var dishesList: [DishLightModel] = []
    let service = NetworkServiceAA()

    var body: some View {
        NavigationView {

            VStack(spacing: 13) {
                HStack {
                    Text("Random recipes")
                        .font(.custom(Font.bold, size: 24))
                    Spacer()
                }
                .padding(.horizontal, 16)

                VStack {
                    Text("Get three random recipes 🎁 \nWhat will surprise you today?")
                        .font(.custom(Font.medium, size: 20))

                    GetRandomButton(text: "Get") {
                        Task {
                            do {
                                dishesList = try await service.getRandomDishes(numberLimit: 3)
                            } catch {
                                print("RandomRecipeView error")
                            }
                        }
                    }
                }
                .padding(.bottom, 10)

                ScrollView(showsIndicators: false) {
                    ForEach(dishesList, id: \.id) { dish in
                        NavigationLink(destination: RecipeDetailView(modelData: modelData, id: dish.id)) {
                            HStack {
                                TrendingDishElement(bigSize: true, dish: dish)
                            }
                            .padding(.vertical, 10)
                        }
                    }
                }

                Spacer(minLength: 80)
            }
        }
    }
}

#Preview {
    DishesListView(modelData: ModelData(), dishesList: [], textHeader: "")
}
