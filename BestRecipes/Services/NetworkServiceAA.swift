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
    func getDishById(id: Int) async throws -> RecipeDetails {
        guard let url = URLManager.shared.createURL(id: id) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            let decoder = JSONDecoder()
            do {
                let dishById = try decoder.decode(RecipeDetails.self, from: data)
                return dishById
            } catch {
                throw NetworkError.badData
            }
        } catch {
            throw NetworkError.badResponse
        }
    }

    // MARK: - dishes by course

    func getDishByCources(cource: Course, numberLimit: Int) async throws -> RecipeByCourseResponse {
        guard let url = URLManager.shared.createURL(course: cource, numberLimit: numberLimit) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            let decoder = JSONDecoder()
            do {
                let recipeByCourse = try decoder.decode(RecipeByCourseResponse.self, from: data)
                return recipeByCourse
            } catch {
                throw NetworkError.badData
            }
        } catch {
            throw NetworkError.badResponse
        }
    }

    // MARK: - dishes by cuisine

    func getDishByCuisine(cuisine: Cuisine, numberLimit: Int) async throws -> RecipeByCuisineResponse {
        guard let url = URLManager.shared.createURL(cuisine: cuisine, numberLimit: numberLimit) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            let decoder = JSONDecoder()
            do {
                let recipeByCuisine = try decoder.decode(RecipeByCuisineResponse.self, from: data)
                return recipeByCuisine
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
