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
    
    //v3
    @Published var dishById = RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 0, healthScore: 2, creditsText: "", sourceName: "", pricePerServing: 0.1, extendedIngredients: [], id: 2, title: "", readyInMinutes: 2, servings: 1, sourceURL: "", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 0.2)

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


    func fetchDishById3(id: Int) async throws {
        var fetchedDishById: RecipeDetails
        fetchedDishById = try await service.getDishById3(id: id)
        dishById = fetchedDishById
    }

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
        fetchedRandomDishes = try await service.getRandomDishes(numberLimit: numberLimit)
        randomDishes = fetchedRandomDishes
    }
}
