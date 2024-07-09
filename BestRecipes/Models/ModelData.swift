//
//  ModelData.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import Foundation
import SwiftUI

@MainActor
class ModelData: ObservableObject {

    // trending dishes
    @Published var trendingDishes: [DishLightModel] = []
    //popular categories (FoodCategory)
    @Published var foodCategoryArray = FoodCategory.allCases.map {$0.rawValue}
    @Published var foodCategoryPopularDishes: [DishLightModel] = []
    //Search array
    @Published var searchText: String = ""
    @Published var searchDishes: [DishLightModel] = []
    //Cuisine recipes
    @Published var cuisineArray = Cuisine.allCases.map {$0.rawValue}
    @Published var cuisineDishes: [DishLightModel] = []
    
    
//    UserDefaults "Recent"
    var recentDishesID: [Int] = []
    @Published var recentDishes: [DishLightModel] = []
    
//    saved array "Saved" UserDefaults key
    var savedDishesID: [Int] = []
    @Published var savedDishes: [DishLightModel] = []
    

    //service
    let service = NetworkServiceAA()

    func fetchAllData() async throws {
        // get trending
        do {
            trendingDishes = try await service.getTrendingDishes(numberLimit: 10)
        }
        catch {
            print("Fetch trending dishes problem")
        }
        // get popular category from first elem
        do {
            foodCategoryPopularDishes = try await service.getDishByFoodCategory(foodCategory: FoodCategory.mainCourse.rawValue, numberLimit: 10)
        } catch {
            print("fetch dish by food category problem")
        }

        //TODO: -get recent from userDef and ID
        recentDishesID = getUserDef("Recent")
        savedDishesID = getUserDef("Saved")
        do {
            if !recentDishesID.isEmpty { recentDishes = try await service.getRecipe(intArray: recentDishesID) }
            if !savedDishesID.isEmpty { savedDishes = try await service.getRecipe(intArray: savedDishesID) }
        } catch {
            print("recent get error")
        }

    }
// Fetch dish by cuisine
    func fetchDishByCuisine(_ cuisine: String) async throws {
        do {
            cuisineDishes = try await service.getDishByCuisine(cuisine: cuisine, numberLimit: 10)
        } catch {
            print("problem with get dish by cuisine")
        }
    }
// fetchDishByFoodCategory
    func fetchDishByFoodCategory(_ foodCategory: String) async throws {
        foodCategoryPopularDishes = try await service.getDishByFoodCategory(foodCategory: foodCategory, numberLimit: 10)
    }
    
    func fetchDishByFoodCategory (_ course: String) {
        print("in function")
        Task {
            do {
                try await fetchDishByFoodCategory(course)
            } catch {
                print("error fetch by cource")
            }
        }
    }
    func fetchSearch() async throws {
        do {
            searchDishes = try await service.getDishesByName(name: searchText, numberLimit: 10)
        } catch {
            print("problem with search")
        }
    }
    
    func getUserDef(_ key: String) -> [Int] {
        if let recent: [Int] = UserDefaultsService.shared.get(forKey: key) {
            return recent
        }
        return []
    }
     
}
