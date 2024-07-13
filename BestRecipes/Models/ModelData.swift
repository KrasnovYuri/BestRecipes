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
    //user name
    @Published var userName: String = ""
    @Published var userSurname: String = ""
    
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
    @Published var tabBarHide: Bool = false
    
    //    UserDefaults "Recent"
    @Published var recentDishesID: [Int] = []
    @Published var recentDishes: [DishLightModel] = []
    
    //    saved array "Favorite" UserDefaults key
    @Published var favoriteDishesID: [Int] = []
    @Published var favoriteDishes: [DishLightModel] = []
    
    // saced array "Saved" UserDefaults ket
    @Published var savedDishies: [DishUserModel] = []
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
        
        //get dishes from UserDef
        recentDishesID = getUserDef("Recent")
        loadRecentDishes()
        favoriteDishesID = getUserDef("Favorite")
        loadFavoriteDishes()
        loadSavedRecipes()
        loadUserName()
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
    // fetch dish by food category
    func fetchDishByFoodCategory (_ course: String) {
        Task {
            do {
                try await fetchDishByFoodCategory(course)
            } catch {
                print("error fetch by cource")
            }
        }
    }
    // fetch search
    func fetchSearch() async throws {
        do {
            searchDishes = try await service.getDishesByName(name: searchText, numberLimit: 10)
        } catch {
            print("problem with search")
        }
    }
    // TODO: - check
    func getUserDef(_ key: String) -> [Int] {
        if let recent: [Int] = UserDefaultsService.shared.get(forKey: key) {
            return recent
        }
        return []
    }
    
    func saveRecent(id: Int) {
        if !recentDishesID.contains(id) {
            recentDishesID.insert(id, at: 0)
            UserDefaultsService.shared.save(structs: recentDishesID, forKey: "Recent")
            loadRecentDishes()
        }
    }
    
    func loadRecentDishes() {
        Task {
            do {
                recentDishes = try await service.getRecipeBulk(intArray: recentDishesID)
            } catch {
                print("fetch recent dishes by array Ids error")
            }
        }
    }
    
    func loadFavoriteDishes () {
        Task {
            do {
                favoriteDishes = try await service.getRecipeBulk(intArray: favoriteDishesID)
            } catch {
                print("fetch recent dishes by array Ids error")
            }
        }
    }
    
    func checkFavorite (id: Int) -> Bool {
        favoriteDishesID.contains(id)
    }
    
    func saveToFavorite (id: Int) {
        if !favoriteDishesID.contains(id) {
            favoriteDishesID.append(id)
            UserDefaultsService.shared.save(structs: favoriteDishesID, forKey: "Favorite")
            loadFavoriteDishes()
        }
    }
    
    func deleteFromFavorite (id: Int) {
        if favoriteDishesID.contains(id) {
            let arrayIn = favoriteDishesID.filter { a in id != a }
            favoriteDishesID = arrayIn
            loadFavoriteDishes()
        }
    }
    
    func loadSavedRecipes() {
        if let savedRecepies: [DishUserModel] = UserDefaultsService.shared.get(forKey: "Saved") {
            savedDishies = savedRecepies
        }
    }
    
    func saveSavedRecipe (recipe: DishUserModel) {
        if savedDishies.isEmpty {
            UserDefaultsService.shared.save(structs: [recipe], forKey: "Saved")
            savedDishies = [recipe]
        } else {
            if var savedRecepies: [DishUserModel] = UserDefaultsService.shared.get(forKey: "Saved") {
                savedRecepies.append(recipe)
                UserDefaultsService.shared.save(structs: savedRecepies, forKey: "Saved")
                savedDishies = savedRecepies
            }
        }
    }
    
    func deleteFromSaved(recipeId: Int) {
        if let savedRecepies: [DishUserModel] = UserDefaultsService.shared.get(forKey: "Saved") {
            let result = savedRecepies.filter { dish in
                dish.id != recipeId
            }
            UserDefaultsService.shared.save(structs: result, forKey: "Saved")
            savedDishies = result
        }
    }
    
    func loadProfileImage(path: String) -> Image {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let folderURL = documentsURL.appendingPathComponent("BestRecipes")
        let fileURL = folderURL.appendingPathComponent(path)
        if FileManager.default.fileExists(atPath: folderURL.path),
           let loadImage = UIImage(contentsOfFile: fileURL.path) {
            return Image(uiImage: loadImage)
        }
        return Image(systemName: "xmark")
    }
    
    func loadUserName () {
        if let username: String = UserDefaultsService.shared.get(forKey: "nameUser") {
            if username.count < 1 {
                UserDefaultsService.shared.save(structs: "Gordon", forKey: "nameUser")
                self.userName = "Gordon"
            } else {
                userName = username
            }
        }
        if let surname : String = UserDefaultsService.shared.get(forKey: "surnameUser") {
            if surname.count < 1 {
                UserDefaultsService.shared.save(structs: "Ramsey", forKey: "nameUser")
                self.userSurname = "Ramsey"
            } else {
                userSurname = surname
            }
        }
    }
    
    init() {
        Task {
            do {
                try await fetchAllData()
            } catch {
                print("fetchh all data from init dataModel")
            }
        }
    }
}
