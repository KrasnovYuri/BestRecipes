//
//  ModelData.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import Foundation

@MainActor
class ModelData: ObservableObject {

    @Published var smallDishesAuto = [DishSmallModel]()
//    @Published var dish = DishBigModel(id: 0)
    @Published var smallDishesCource = [DishSmallModel]()
    @Published var smallDishesCuisine = [DishSmallModel]()
    @Published var randomDishes = [DishBigModel]()

    let service = NetworkServiceAA()

    // get dishes by name with autocomplition
    func fetchSmallDishesAuto(name: String, numberLimit: Int) async throws {
        var fetchedSmallDishesAuto: [DishSmallModel]
        fetchedSmallDishesAuto = try await service.getDishesByName(name: name, numberLimit: numberLimit)
        smallDishesAuto = fetchedSmallDishesAuto
    }

    //get dish by ID
    func fetchDishById(id: Int) async throws {
        var fetchedDishById: DishBigModel
        fetchedDishById = try await service.getDishById(id: id)
//        dish = fetchedDishById
    }

    //get dishes by course
    func fetchDishByCources(course: Course, numberLimit: Int) async throws {
        var fetchedDishByCources: [DishSmallModel]
        fetchedDishByCources = try await service.getDishByCources(cource: course, numberLimit: numberLimit)
        smallDishesCource = fetchedDishByCources
    }

    //get dishes by cuisine
    func fetchDishByCuisine(cuisine: Cuisine, numberLimit: Int) async throws {
        var fetchedDishByCuisine: [DishSmallModel]
        fetchedDishByCuisine = try await service.getDishByCuisine(cuisine: cuisine, numberLimit: numberLimit)
        smallDishesCuisine = fetchedDishByCuisine
    }

    //get random dishes
    func fetchRandomDishes(numberLimit: Int) async throws {
        var fetchedRandomDishes: [DishBigModel] = []
        print(fetchedRandomDishes.count)
        fetchedRandomDishes = try await service.getRandomDishes(numberLimit: numberLimit)
        print(fetchedRandomDishes.count)
        randomDishes = fetchedRandomDishes
    }
}
