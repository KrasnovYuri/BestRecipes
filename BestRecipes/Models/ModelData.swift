//
//  ModelData.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import Foundation

@MainActor
class ModelData: ObservableObject {
    
    // trending 5 dishes
    @Published var trendingDishes: [RecipeDetails] = []
    //trending categories
    @Published var categoriesCuisine: [String] = []
    @Published var categoriesDishes: [[RecipeDetails]] = [[]]
    //search array
    @Published var searchDishes: [RecipeDetails] = []
    //v3
//    @Published var dishById = RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 0, healthScore: 2, creditsText: "", sourceName: "", pricePerServing: 0.1, extendedIngredients: [], id: 2, title: "", readyInMinutes: 2, servings: 1, sourceURL: "", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 0.2)
//    
    // MARK: - it works
    @Published var recipeByCourse = RecipeByCourseResponse(results: [], offset: 0, number: 0, totalResults: 0)
    @Published var recipeByCuisine: [RecipeByCuisine] = []
    @Published var randomDishes : [RecipeByCuisine] = []
    
    let service = NetworkServiceAA()
    
    // get dishes by name with autocomplition
    func fetchSmallDishesAuto(name: String, numberLimit: Int) async throws -> [DishSmallModel] {
        try await service.getDishesByName(name: name, numberLimit: numberLimit)
    }
    
    // get dishes by ID
    func fetchDishById(id: Int) async throws -> RecipeDetails {
        try await service.getDishById3(id: id)
        
    }
    
    // get dishes by courses
    func fetchDishByCources(course: Course, numberLimit: Int) async throws -> [RecipeByCourse] {
        try await service.getDishByCources(cource: course, numberLimit: numberLimit)
    }
    
    //get dishes by cuisine
    func fetchDishByCuisine(cuisine: Cuisine.RawValue, numberLimit: Int) async throws -> [RecipeByCuisine] {
        try await service.getDishByCuisine(cuisine: cuisine, numberLimit: numberLimit)
    }
    
    //get random dishes
    func fetchRandomDishes(numberLimit: Int) async throws -> [DishBigModel] {
        try await service.getRandomDishes(numberLimit: numberLimit)
    }
    
    func fetchAllData() async throws {
        do {
            var trendingDishesSmall = try await fetchRandomDishes(numberLimit: 5)
            for dish in trendingDishesSmall {
                trendingDishes.append(try await fetchDishById(id: dish.id))
            }
        }
        catch {
            print("Fetch trending dishes")
        }
        do {
            getRandomCategories()
            let categoriesFor = categoriesCuisine
            var categoriesDishes: [[RecipeDetails]] = [[]]
            for index in categoriesFor.indices {
                let dishes = try await fetchDishByCuisine(cuisine: categoriesFor[index], numberLimit: 5)
                for dish in dishes {
                    let dishId = try await fetchDishById(id: dish.id)
                    categoriesDishes[index].append(dishId)
                }
            }
            self.categoriesDishes = categoriesDishes
            
        } catch {
            print("Fetch categories dishes")
        }
    }
    
    func getRandomCategories () {
        let curceArray = Cuisine.allCases.map {$0.rawValue}
        var randomCuisine: [String] = []
        for _ in 0...6 {
            if let check = curceArray.randomElement() {
                randomCuisine.append ( check )
            }
        }
        categoriesCuisine = randomCuisine
    }
}
