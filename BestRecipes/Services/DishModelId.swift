//
//  DishModelById.swift
//  BestRecipes
//
//  Created by Evgeniy K on 02.07.2024.
//
import Foundation

struct RecipeDetails: Codable, Identifiable {
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let veryHealthy: Bool
    let cheap: Bool
    let veryPopular: Bool
    let sustainable: Bool
    let lowFodmap: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let preparationMinutes: Int?
    let cookingMinutes: Int?
    let aggregateLikes: Int
    let healthScore: Int
    let creditsText: String
    let sourceName: String
    let pricePerServing: Double
    let extendedIngredients: [ExtendedIngredient]
    //
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
    let image: String
    let imageType: String
    let summary: String
    let cuisines: [String]
    let dishTypes: [String]
    let diets: [String]
    let instructions: String
    let analyzedInstructions: [AnalyzedInstruction]
    let spoonacularScore: Double
    let spoonacularSourceUrl: String
}

struct ExtendedIngredient: Codable, Identifiable {
    let id: Int
    let aisle: String
    let image: String
    let consistency: String
    let name: String
    let nameClean: String
    let original: String
    let originalName: String
    let amount: Int
    let unit: String
    let meta: [String]
    let measures: MeasuresID
    //
}

struct MeasuresID: Codable {
    let us: MeasureInfoUS
    let metric: MeasureInfoMetric
}

struct MeasureInfoUS: Codable {
    let amount: Double
    let unitShort: String
    let unitLong: String
}
struct MeasureInfoMetric: Codable {
    let amount: Double
    let unitShort: String
    let unitLong: String
}

struct AnalyzedInstruction: Codable {
    let name: String
    let steps: [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
    let ingredients: [IngredientReference]
    let equipment: [EquipmentReference]
}

struct IngredientReference: Codable, Identifiable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
}

struct EquipmentReference: Codable, Identifiable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
}
