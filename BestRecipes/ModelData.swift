//
//  ModelData.swift
//  BestRecipes
//
//  Created by Evgeniy K on 30.06.2024.
//

import Foundation

@MainActor
class ModelData: ObservableObject {

    let service = NetworkServiceAA()

    @Published var smallDishesAuto = [DishSmallModel]()
    @Published var dish = DishBigModel()
    @Published var smallDishesCource = [DishSmallModel]()
    @Published var smallDishesCuisine = [DishSmallModel]()
    @Published var randomDishes = [DishSmallModel]()

}
