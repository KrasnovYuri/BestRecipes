//
//  DishLightModel.swift
//  BestRecipes
//
//  Created by Руслан on 09.07.2024.
//

import Foundation

struct DishLightModel: Identifiable, Codable {
    let title: String
    let id: Int
    let spoonacularScore: Double
    let readyInMinutes: Int
    let creditsText: String
    let ingredientsCount: Int
    var imagePath: String = ""
    
    init(_ dish: RecipeDetails) {
        title = dish.title
        id = dish.id
        spoonacularScore = dish.spoonacularScore
        readyInMinutes = dish.readyInMinutes
        creditsText = dish.creditsText
        ingredientsCount = dish.extendedIngredients.count
    }
    
    init () {
        title = "Red Lentil Soup with Chicken and Turnips"
        id = 715415
        spoonacularScore = 35.0
        readyInMinutes = 55
        creditsText = "povar"
        ingredientsCount = 13
    }
    
    init(title: String, id: Int, spoonacularScore: Double, readyInMinutes: Int, creditsText: String, ingredientsCount: Int) {
        self.title = title
        self.id = id
        self.spoonacularScore = spoonacularScore
        self.readyInMinutes = readyInMinutes
        self.creditsText = creditsText
        self.ingredientsCount = ingredientsCount
    }
    
    init (userModel: DishUserModel) {
        title = userModel.title
        id = userModel.id
        spoonacularScore = userModel.spoonacularScore
        readyInMinutes = userModel.readyInMinutes
        creditsText = userModel.creditsText
        ingredientsCount = userModel.ingredientsCount
        imagePath = "userDish\(userModel.id).jpg"
    }
}



