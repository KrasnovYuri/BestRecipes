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
    
//    @Published var dishById = DishBigModel(id: 0, title: "", readyInMinutes: 0, servings: 0, image: nil, sourceUrl: URL(string: "")!, cuisines: [], dishTypes: [], diets: [], occasions: [], summary: "", instructions: "", extendedIngredients: [], pricePerServing: 0)

    // MARK: - it works
    @Published var recipeByCourse = RecipeByCourseResponse(results: [], offset: 0, number: 0, totalResults: 0)
    @Published var recipeByCuisine = RecipeByCuisineResponse(results: [], offset: 0, number: 0, totalResults: 0)
    @Published var randomDishes = [DishBigModel]()

    let service = NetworkServiceAA()

    // get dishes by name with autocomplition
    func fetchSmallDishesAuto(name: String, numberLimit: Int) async throws {
        var fetchedSmallDishesAuto: [DishSmallModel]
        fetchedSmallDishesAuto = try await service.getDishesByName(name: name, numberLimit: numberLimit)
        smallDishesAuto = fetchedSmallDishesAuto
    }

    //get dish by ID
//    func fetchDishById(id: Int) async throws {
//        var fetchedDishById: DishBigModel
//        fetchedDishById = try await service.getDishById(id: id)
//        dishById = fetchedDishById
//    }

    // MARK: - get dishes by courses
    func fetchDishByCources(course: Course, numberLimit: Int) async throws {
        var fetchedDishByCources: RecipeByCourseResponse
        fetchedDishByCources = try await service.getDishByCources(cource: course, numberLimit: numberLimit)
        recipeByCourse = fetchedDishByCources
    }

    // MARK: - get dishes by cuisine
    func fetchDishByCuisine(cuisine: Cuisine, numberLimit: Int) async throws {
        var fetchedDishByCuisine: RecipeByCuisineResponse
        fetchedDishByCuisine = try await service.getDishByCuisine(cuisine: cuisine, numberLimit: numberLimit)
        recipeByCuisine = fetchedDishByCuisine
    }

    // MARK: - get random dishes
    func fetchRandomDishes(numberLimit: Int) async throws {
        var fetchedRandomDishes: [DishBigModel] = []
        print(fetchedRandomDishes.count)
        fetchedRandomDishes = try await service.getRandomDishes(numberLimit: numberLimit)
        print(fetchedRandomDishes.count)
        randomDishes = fetchedRandomDishes
    }
}
