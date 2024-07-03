//
//  NetworkServiceAA.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import Foundation

actor NetworkServiceAA {
    
    // get dishes by name with autocomplition
    func getDishesByName(name: String, numberLimit: Int) async throws -> [DishSmallModel] {
        guard let url = URLManager.shared.createURL(name, numberLimit: numberLimit) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            let decoder = JSONDecoder()
            do {
                let smallDishes = try decoder.decode([DishSmallModel].self, from: data)
                return smallDishes
            } catch {
                throw NetworkError.badData
            }
        }
        catch {
            throw NetworkError.badResponse
        }
    }
    
    // get dish by ID
    // https://api.spoonacular.com/recipes/3/information?apiKey=856702108d404eedb8ebb7694ab6f67c
    
    // get dish by ID 3
    func getDishById3(id: Int) async throws -> RecipeDetails {
        
        var dish = RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 0, healthScore: 2, creditsText: "", sourceName: "", pricePerServing: 0.1, extendedIngredients: [], id: 2, title: "", readyInMinutes: 2, servings: 1, sourceURL: "", image: "", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: nil, analyzedInstructions: [], originalID: nil, spoonacularScore: 0.2)
        
        guard let url = URLManager.shared.createURL(id: id) else {
            throw NetworkError.badURL
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let decodedDish = try? JSONDecoder().decode(RecipeDetails.self, from: data) else {
            throw NetworkError.invalidDecoding
        }
        
        dish = decodedDish
        return dish
    }
    
    
    // MARK: - dishes by course
    
    func getDishByCources(cource: Course, numberLimit: Int) async throws -> [RecipeByCourse] {
        guard let url = URLManager.shared.createURL(course: cource, numberLimit: numberLimit) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            let decoder = JSONDecoder()
            do {
                let recipeByCourse = try decoder.decode(RecipeByCourseResponse.self, from: data)
                return recipeByCourse.results
            } catch {
                throw NetworkError.badData
            }
        } catch {
            throw NetworkError.badResponse
        }
    }

    // MARK: - dishes by cuisine

    func getDishByCuisine(cuisine: Cuisine.RawValue, numberLimit: Int) async throws -> [RecipeByCuisine] {
        guard let url = URLManager.shared.createURL(cuisine: cuisine, numberLimit: numberLimit) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            let decoder = JSONDecoder()
            do {
                let recipeByCuisine = try decoder.decode(RecipeByCuisineResponse.self, from: data)
                return recipeByCuisine.results
            } catch {
                throw NetworkError.badData
            }
        } catch {
            throw NetworkError.badResponse
        }
    }

    // MARK: - get random dishes

    func getRandomDishes(numberLimit: Int) async throws -> [DishBigModel] {
        guard let url = URLManager.shared.createURL(numberOfDishes: numberLimit) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            print("we have data")
            let data = responce.0
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            print("we have decoder")
            do {
                print("do in")
                let result = try decoder.decode(RecipeData.self, from: data)
                print("finish!")
                return result.recipes
            } catch {
                throw NetworkError.badData
            }
        } catch {
            throw NetworkError.badResponse
        }
    }
}

enum NetworkError: Error {
    case badURL
    case badData
    case badResponse
    case invalidDecoding
}
