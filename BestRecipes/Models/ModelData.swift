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
    //popular categories
    @Published var courceArray = Course.allCases.map {$0.rawValue}
    @Published var popularDishes: [RecipeDetails] = []
    //recent recipe "Recent" UserDefaults key
    var recentDishesID: [Int] = []
    @Published var recentDishes: [RecipeDetails] = []
    //Cuisine recipes
    @Published var cuisineArray = Cuisine.allCases.map {$0.rawValue}
    @Published var cuisineDishes: [RecipeDetails] = []
    //search array
    @Published var searchText: String = ""
    @Published var searchDishes: [RecipeDetails] = []
    //saved array "Saved" UserDefaults key
    var savedDishesID: [Int] = []
    @Published var savedDishes: [RecipeDetails] = []

    //v3
    //    @Published var dishById = RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 0, healthScore: 2, creditsText: "", sourceName: "", pricePerServing: 0.1, extendedIngredients: [], id: 2, title: "", readyInMinutes: 2, servings: 1, sourceURL: "", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 0.2)
    //
    // MARK: - it works
    @Published var recipeByCourse = RecipeByCourseResponse(results: [], offset: 0, number: 0, totalResults: 0)
    @Published var recipeByCuisine: [RecipeByCuisine] = []

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
    func fetchDishByCources(course: Course.RawValue, numberLimit: Int) async throws -> [RecipeByCourse] {
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
        // get trending from random
        do {
            let trendingDishesSmall = try await fetchRandomDishes(numberLimit: 5)
            for dish in trendingDishesSmall {
                trendingDishes.append(try await fetchDishById(id: dish.id))
            }
        }
        catch {
            print("Fetch trending dishes")
        }
        // get cource from first elem
        do {
            let courseStr = courceArray[0]
            let popularDishesIn = try await fetchDishByCources(course: courseStr, numberLimit: 10)
            for dish in popularDishesIn {
                popularDishes.append(try await fetchDishById(id: dish.id))
            }
        }
        catch {
            print("Fetch cource dishes")
        }
        //get recent from userDef and ID
        if let arrayStr: [Int] = UserDefaultsService.shared.get(forKey: "Recent") {
            recentDishesID = arrayStr
        }
        if !recentDishesID.isEmpty {
            do {
                for dish in recentDishesID {
                    recentDishes.append(try await fetchDishById(id: dish))
                }
            } catch {
                print("Fetch recent dishes")
            }
        }
        //get cuisine from first elem
        do {
            let cuisineStr = cuisineArray[0]
            let cuisineDishesIn = try await fetchDishByCources(course: cuisineStr, numberLimit: 10)
            for dish in cuisineDishesIn {
                cuisineDishes.append(try await fetchDishById(id: dish.id))
            }

        }
        catch {
            print("Fetch cuisine dishes")
        }

    }

    func fetchDishByCuisine(_ cuisine: String) async throws {
        do {
            let dishes = try await fetchDishByCuisine(cuisine: cuisine, numberLimit: 10)
            var recipes: [RecipeDetails] = []
            for dish in dishes {
                recipes.append(try await fetchDishById(id: dish.id))
            }
            cuisineDishes = recipes
        } catch {
            print("problem with get dish by course")
        }
    }

    func fetchDishByCourse(_ course: String) async throws {
        do {
            let dishes = try await fetchDishByCources(course: course, numberLimit: 10)
            var recipes: [RecipeDetails] = []
            for dish in dishes {
                recipes.append(try await fetchDishById(id: dish.id))
            }
            popularDishes = recipes
        } catch {
            print("problem with get dish by course")
        }
    }
    func fetchSearch() async throws {
        print("i am in fetch search")
        do {
            let searchArray = try await fetchSmallDishesAuto(name: searchText, numberLimit: 10)
            var recipesName: [RecipeDetails] = []
            for dish in searchArray {
                recipesName.append(try await fetchDishById(id: dish.id))
            }
            searchDishes = recipesName
        } catch {
            print("problem with search")
        }
    }
    

    //init() {
    //    trendingDishes = [(RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 6, healthScore: 2, creditsText: "Edoman", sourceName: "12esd", pricePerServing: 0.1, extendedIngredients: [], id: 214212, title: "Very cool dish with garlic", readyInMinutes: 6, servings: 1, sourceURL: "23", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 92.2)),(RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 6, healthScore: 2, creditsText: "Edoman", sourceName: "12esd", pricePerServing: 0.1, extendedIngredients: [], id: 214212, title: "Very cool dish with garlic", readyInMinutes: 6, servings: 1, sourceURL: "23", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 92.2)),(RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 6, healthScore: 2, creditsText: "Edoman", sourceName: "12esd", pricePerServing: 0.1, extendedIngredients: [], id: 214612, title: "Very cool dish with garlic", readyInMinutes: 6, servings: 1, sourceURL: "23", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 92.2)),(RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 6, healthScore: 2, creditsText: "Edoman", sourceName: "12esd", pricePerServing: 0.1, extendedIngredients: [], id: 214212, title: "Very cool dish with garlic", readyInMinutes: 6, servings: 1, sourceURL: "23", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 92.2)),(RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 6, healthScore: 2, creditsText: "Edoman", sourceName: "12esd", pricePerServing: 0.1, extendedIngredients: [], id: 224212, title: "Very cool dish with garlic", readyInMinutes: 6, servings: 1, sourceURL: "23", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 92.2))]
    //    popularDishes = [(RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 6, healthScore: 2, creditsText: "Kitchen paris norn", sourceName: "12esd", pricePerServing: 0.1, extendedIngredients: [], id: 284213, title: "Meat with cheese and another", readyInMinutes: 6, servings: 1, sourceURL: "23", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 92.2)),]
    //    recentDishes = [(RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 6, healthScore: 2, creditsText: "Kitchen moscow norn", sourceName: "12esd", pricePerServing: 0.1, extendedIngredients: [], id: 219213, title: "Pork and another", readyInMinutes: 6, servings: 1, sourceURL: "23", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 92.2)),]
    //    savedDishes = [(RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 6, healthScore: 2, creditsText: "Kitchen moscow norn", sourceName: "12esd", pricePerServing: 0.1, extendedIngredients: [], id: 217113, title: "Pork and another", readyInMinutes: 6, servings: 1, sourceURL: "23", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 92.2)),]
    //    recipeByCourse = recipeByCourse
    //    recipeByCuisine = recipeByCuisine
    //}
}
