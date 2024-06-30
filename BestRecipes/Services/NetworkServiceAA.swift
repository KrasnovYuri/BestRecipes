//
//  NetworkServiceAA.swift
//  BestRecipes
//
//  Created by Руслан on 30.06.2024.
//

import Foundation

class NetworkServiceAA {
    static let shared = NetworkServiceAA() ; private init() {}
    
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
    func getDishById(id: String) async throws -> DishBigModel {
        guard let url = URLManager.shared.createURL(id: id) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            let decoder = JSONDecoder()
            do {
                let dish = try decoder.decode(DishBigModel.self, from: data)
                return dish
            } catch {
                throw NetworkError.badData
            }
        }
        catch {
            throw NetworkError.badResponse
            
        }
    }
    //get dishes by cource
    func getDishByCources(cource: Course, numberLimit: Int) async throws -> [DishSmallModel] {
        guard let url = URLManager.shared.createURL(course: cource, numberLimit: numberLimit) else {
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
    //get dishes by cuisine
    func getDishByCuisine(cuisine: Cuisine, numberLimit: Int) async throws -> [DishSmallModel] {
        guard let url = URLManager.shared.createURL(cuisine: cuisine, numberLimit: numberLimit) else {
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
    //get random dishes
    
    func getRandomDishes(numberLimit: Int) async throws -> [DishSmallModel] {
        guard let url = URLManager.shared.createURL(numberOfDishes: numberLimit) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            let decoder = JSONDecoder()
            do {
                let randomDishes = try decoder.decode([DishSmallModel].self, from: data)
                return randomDishes
            } catch {
                throw NetworkError.badData
            }
        }
        catch {
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
