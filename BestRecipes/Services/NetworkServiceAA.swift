//
//  NetworkServiceAA.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import Foundation
import SwiftyJSON

actor NetworkServiceAA {
    
    
    // MARK: - Search, get dishes by name with autocomplition
    func getDishesByName(name: String, numberLimit: Int) async throws -> [DishLightModel] {
        guard let url = URLManager.shared.createURL(name, numberLimit: numberLimit) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            if let json = try? JSON(data: responce.0) {
                let arrayNames =  json.arrayValue.map { $0["id"].intValue }
                guard let url2 = URLManager.shared.createURLBulk(id: arrayNames) else { throw NetworkError.badURL }
                do {
                    let responce = try await URLSession.shared.data(from: url2)
                    if let json2 = try? JSON(data: responce.0) {
                        var dishReturn: [DishLightModel] = []
                        for element in json2.arrayValue {
                            dishReturn.append(DishLightModel(title: element["title"].stringValue, id: element["id"].intValue, spoonacularScore: element["spoonacularScore"].doubleValue, readyInMinutes: element["readyInMinutes"].intValue, creditsText: element["creditsText"].stringValue, ingredientsCount: element["extendedIngredients"].arrayValue.count))
                        }
                        return dishReturn
                    }
                } catch {
                    throw NetworkError.badResponse
                }
            }
        }
        catch {
            throw NetworkError.badResponse
        }
        return []
    }
    
    // MARK: - get dish by ID
    func getDishById(id: Int) async throws -> RecipeDetails {
        
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
        
        return decodedDish
    }
    
    
    // MARK: - Popular category (Food category)
    
    // сразу получение легкой модели без всякого
    func getDishByFoodCategory(foodCategory: String, numberLimit: Int) async throws -> [DishLightModel] {
        guard let url = URLManager.shared.createURL(foodCategory: foodCategory, numberLimit: numberLimit) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            if let json = try? JSON(data: responce.0) {
                let arrayNames =  json["results"].arrayValue.map { $0["id"].intValue }
                guard let url2 = URLManager.shared.createURLBulk(id: arrayNames) else { throw NetworkError.badURL }
                do {
                    let responce = try await URLSession.shared.data(from: url2)
                    if let json2 = try? JSON(data: responce.0) {
                        var dishReturn: [DishLightModel] = []
                        for element in json2.arrayValue {
                            dishReturn.append(DishLightModel(title: element["title"].stringValue, id: element["id"].intValue, spoonacularScore: element["spoonacularScore"].doubleValue, readyInMinutes: element["readyInMinutes"].intValue, creditsText: element["creditsText"].stringValue, ingredientsCount: element["extendedIngredients"].arrayValue.count))
                        }
                        return dishReturn
                    }
                } catch {
                    throw NetworkError.badResponse
                }
            }
            
        } catch {
            throw NetworkError.badResponse
        }
        return []
    }
    // MARK: - dishes by cuisine
    
    func getDishByCuisine(cuisine: Cuisine.RawValue, numberLimit: Int) async throws -> [DishLightModel] {
        guard let url = URLManager.shared.createURL(cuisine: cuisine, numberLimit: numberLimit) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            if let json = try? JSON(data: responce.0) {
                var dishReturn: [DishLightModel] = []
                for element in json["recipes"].arrayValue {
                    dishReturn.append(DishLightModel(title: element["title"].stringValue, id: element["id"].intValue, spoonacularScore: element["spoonacularScore"].doubleValue, readyInMinutes: element["readyInMinutes"].intValue, creditsText: element["creditsText"].stringValue, ingredientsCount: element["extendedIngredients"].arrayValue.count))
                }
                print("dishReturn cuisine")
                print(dishReturn.count)
                return dishReturn
            }
        } catch {
            throw NetworkError.badResponse
        }
        return []
    }
    
    // MARK: - get random dishes
    
    func getRandomDishes(numberLimit: Int) async throws -> [DishLightModel] {
        guard let url = URLManager.shared.createURL(numberOfDishes: 3) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            if let json = try? JSON(data: responce.0) {
                var dishReturn: [DishLightModel] = []
                for element in json["recipes"].arrayValue {
                    dishReturn.append(DishLightModel(title: element["title"].stringValue, id: element["id"].intValue, spoonacularScore: element["spoonacularScore"].doubleValue, readyInMinutes: element["readyInMinutes"].intValue, creditsText: element["creditsText"].stringValue, ingredientsCount: element["extendedIngredients"].arrayValue.count))
                }
                return dishReturn
            }
        } catch {
            throw NetworkError.badResponse
        }
        return []
    }

    // MARK: - get popular dishes
    
    func getTrendingDishes(numberLimit: Int) async throws -> [DishLightModel] {
        guard let url = URLManager.shared.createURL(numberOfPopularDishes: numberLimit) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            if let json = try? JSON(data: responce.0) {
                var dishReturn: [DishLightModel] = []
                for element in json["recipes"].arrayValue {
                    dishReturn.append(DishLightModel(title: element["title"].stringValue, id: element["id"].intValue, spoonacularScore: element["spoonacularScore"].doubleValue, readyInMinutes: element["readyInMinutes"].intValue, creditsText: element["creditsText"].stringValue, ingredientsCount: element["extendedIngredients"].arrayValue.count))
                }
                return dishReturn
            }
        } catch {
            throw NetworkError.badResponse
        }
        return []
    }

    //MARK: - get dish by Int(id) array
    func getRecipeBulk(intArray: [Int]) async throws -> [DishLightModel] {
        guard let url = URLManager.shared.createURLBulk(id: intArray) else { throw NetworkError.badURL }
        do {
            let responce = try await URLSession.shared.data(from: url)
            if let json = try? JSON(data: responce.0) {
                var dishReturn: [DishLightModel] = []
                for element in json.arrayValue {
                    dishReturn.append(DishLightModel(title: element["title"].stringValue, id: element["id"].intValue, spoonacularScore: element["spoonacularScore"].doubleValue, readyInMinutes: element["readyInMinutes"].intValue, creditsText: element["creditsText"].stringValue, ingredientsCount: element["extendedIngredients"].arrayValue.count))
                }
                return dishReturn
            }
        } catch {
            throw NetworkError.badResponse
        }
        return []
    }
}

enum NetworkError: Error {
    case badURL
    case badData
    case badResponse
    case invalidDecoding
}
