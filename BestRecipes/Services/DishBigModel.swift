//
//  DishBigModel.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

//import Foundation
//struct ResultInto: Codable {
//    var results: [DishBigModel]
//}
//struct DishBigModel: Identifiable, Codable {
//    var id: Int
//    var extendedIngredients: [Ingredients]
//    var title: String
//    var readyInMinutes: Int
//    var image: String
//    var analyzedInstructions: [Instruction]
//    var spoonacularScore: Double
//}
//
//struct Ingredients: Identifiable, Codable {
//    var id: Int
//    var image: String
//    var name: String
//    var amount: Int
//    var unit: String
//}
//
//struct Instruction: Identifiable, Codable {
//    var id = UUID().uuidString
//    var number: Int
//    var step: String
//}

import Foundation

struct Ingredient : Identifiable, Codable  {
    let id: Int
    let aisle: String
    let image: URL?
    let consistency: String
    let name: String
    let nameClean: String
    let original: String
    let originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
    let measures: Measures
}

struct Measures : Codable  {
    let us: MeasureDetails
    let metric: MeasureDetails
}

struct MeasureDetails : Codable  {
    let amount: Double
    let unitShort: String
    let unitLong: String
}

struct DishBigModel: Identifiable, Codable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let image: URL?
    let sourceUrl: URL
    let cuisines: [String]
    let dishTypes: [String]
    let diets: [String]
    let occasions: [String]
    let summary: String
    let instructions: String
    let extendedIngredients: [Ingredient]
    let pricePerServing: Double
}

struct RecipeData: Decodable {
    let recipes: [DishBigModel]
}
