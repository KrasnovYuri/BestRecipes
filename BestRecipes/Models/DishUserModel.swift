//
//  UserDishModel.swift
//  BestRecipes
//
//  Created by Руслан on 12.07.2024.
//

import Foundation


struct DishUserModel: Identifiable, Codable {
    var title: String
    var id: Int
    var spoonacularScore: Double
    var readyInMinutes: Int
    var creditsText: String
    var ingredientsCount: Int
    var imagePath: String = ""
    var ingredients: [UserIngredient] = []
    var serves: Int = 0
    
    init() {
        title = ""
        id = 0
        spoonacularScore = 80.0
        readyInMinutes = 0
        creditsText = "0"
        ingredientsCount = 0
    }
    
    init(title: String, id: Int, score: Double, time: Int, credits: String, imagePath: String, ingredients: [UserIngredient], serves: Int) {
        self.title = title
        self.id = id
        spoonacularScore = score
        readyInMinutes = time
        creditsText = credits
        self.imagePath = imagePath
        self.ingredients = ingredients
        ingredientsCount = ingredients.count
        self.serves = serves
    }
}

struct UserIngredient: Identifiable, Codable {
    var id: String
    var title: String
    var amount: String
    var unit: String
    
    init() {
        id = UUID().uuidString
        title = ""
        amount = ""
        unit = Unit.gr.rawValue
    }
}
