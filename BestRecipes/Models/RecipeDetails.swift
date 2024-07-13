//
//  DishModelById.swift
//  BestRecipes
//
//  Created by Evgeniy K on 02.07.2024.
//
import Foundation


// MARK: - v4
struct RecipeDetails: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy, cheap, veryPopular, sustainable: Bool
    let lowFodmap: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let preparationMinutes, cookingMinutes: Int?
    let aggregateLikes, healthScore: Int
    let creditsText, sourceName: String
    let pricePerServing: Double
    var extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let sourceURL: String
    let image: String
    let imageType, summary: String
    let cuisines: [String]?
    let dishTypes, diets: [String]
    let occasions: [String]?
    let instructions: String?
    let analyzedInstructions: [AnalyzedInstruction]?
    let originalID: Int?
    let spoonacularScore: Double
    
    enum CodingKeys: String, CodingKey {
        case vegetarian, vegan, glutenFree, dairyFree, veryHealthy, cheap, veryPopular, sustainable, lowFodmap, weightWatcherSmartPoints, gaps, preparationMinutes, cookingMinutes, aggregateLikes, healthScore, creditsText, sourceName, pricePerServing, extendedIngredients, id, title, readyInMinutes, servings
        case sourceURL = "sourceUrl"
        case image, imageType, summary, cuisines, dishTypes, diets, occasions, instructions, analyzedInstructions
        case originalID = "originalId"
        case spoonacularScore
    }
    
    init() {
        vegetarian = true
        vegan = true
        glutenFree = true
        dairyFree = true
        veryHealthy = true
        cheap = true
        veryPopular = true
        sustainable = true
        lowFodmap = true
        weightWatcherSmartPoints =  100
        gaps = ""
        preparationMinutes = 30
        cookingMinutes = 30
        aggregateLikes = 30
        healthScore = 30
        creditsText = "Povar"
        sourceName = "Povar"
        pricePerServing = 0.0
        extendedIngredients = []
        id = 122124
        title = "Eda"
        readyInMinutes = 15
        servings = 15
        sourceURL = ""
        image = ""
        imageType = ""
        summary = ""
        cuisines = []
        dishTypes = []
        diets = []
        occasions = []
        instructions = ""
        analyzedInstructions = []
        originalID = nil
        spoonacularScore = 56.0
    }
    
    init(userDish: DishUserModel) {
        vegetarian = true
        vegan = true
        glutenFree = true
        dairyFree = true
        veryHealthy = true
        cheap = true
        veryPopular = true
        sustainable = true
        lowFodmap = true
        weightWatcherSmartPoints =  0
        gaps = ""
        preparationMinutes = userDish.readyInMinutes
        cookingMinutes = userDish.readyInMinutes
        aggregateLikes = userDish.readyInMinutes
        healthScore = 100
        creditsText = userDish.creditsText
        sourceName = userDish.creditsText
        pricePerServing = 0.0
        var extendedIngredientsIn: [ExtendedIngredient] = []
        for ingredient in userDish.ingredients {
            if let userAmountInt = Int(ingredient.amount) {
                extendedIngredientsIn.append(ExtendedIngredient(id: Int.random(in: 1...30000), aisle: "", image: "", consistency: "", name: ingredient.title, nameClean: ingredient.title, original: ingredient.title, originalName: ingredient.title, amount: Double(userAmountInt), unit: ingredient.unit, meta: [], measures: MeasuresBig(us: Metric(amount: Double(userAmountInt), unitShort: ingredient.unit, unitLong: ingredient.unit), metric: Metric(amount: Double(userAmountInt), unitShort: ingredient.unit, unitLong: ingredient.unit))))
            }
        }
        extendedIngredients = extendedIngredientsIn
        id = userDish.id
        title = userDish.title
        readyInMinutes = userDish.readyInMinutes
        servings = userDish.readyInMinutes
        sourceURL = ""
        image = ""
        imageType = ""
        summary = ""
        cuisines = []
        dishTypes = []
        diets = []
        occasions = []
        instructions = ""
        analyzedInstructions = []
        originalID = nil
        spoonacularScore = Double(userDish.spoonacularScore)
    }
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable {
    let id: Int
    let aisle, image, consistency, name: String
    let nameClean, original, originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
    let measures: MeasuresBig
}

// MARK: - Measures
struct MeasuresBig: Codable {
    let us, metric: Metric
}

// MARK: - Metric
struct Metric: Codable {
    let amount: Double
    let unitShort, unitLong: String
}

struct AnalyzedInstruction: Codable {
    let name: String
    let steps: [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
    let ingredients, equipment: [Ent]
    let length: Length?
}

struct Ent: Codable {
    let id: Int
    let name, localizedName: String
    let image: String
}

// MARK: - Length
struct Length: Codable {
    let number: Int
    let unit: String
}
