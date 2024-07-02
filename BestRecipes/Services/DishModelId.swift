////
////  DishModelById.swift
////  BestRecipes
////
////  Created by Evgeniy K on 02.07.2024.
////
//
//import Foundation
//
//// MARK: - RecipeInformation
//struct RecipeInformationID: Identifiable, Codable {
//    let vegetarian, vegan, glutenFree, dairyFree: Bool
//    let veryHealthy, cheap, veryPopular, sustainable: Bool
//    let lowFodmap: Bool
//    let weightWatcherSmartPoints: Int
//    let gaps: String
//    let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int
//    let creditsText, sourceName: String
//    let pricePerServing: Double
//    let extendedIngredients: [ExtendedIngredientID]
//    let id: Int
//    let title: String
//    let readyInMinutes, servings: Int
//    let sourceUrl: String
//    let image: String
//    let imageType: String
//    let summary: String
//    let cuisines, dishTypes, diets, occasions: [String]
//    let instructions: String
//    let analyzedInstructions: [AnalyzedInstructionID]
//    let originalId: String?
//    let spoonacularScore: Double
//}
//
//// MARK: - ExtendedIngredient
//struct ExtendedIngredientID: Identifiable, Codable {
//    let id: Int
//    let aisle, image, consistency, name: String
//    let nameClean, original, originalName: String
//    let amount: Double
//    let unit: String
//    let meta: [String]
//    let measures: MeasuresID
//}
//
//// MARK: - Measures
//struct MeasuresID: Codable {
//    let us, metric: MeasureID
//}
//
//// MARK: - Measure
//struct MeasureID: Codable {
//    let amount: Double
//    let unitShort, unitLong: String
//}
//
//// MARK: - AnalyzedInstruction
//struct AnalyzedInstructionID: Codable {
//    let name: String
//    let steps: [StepID]
//}
//
//// MARK: - Step
//struct StepID: Codable {
//    let number: Int
//    let step: String
//    let ingredients, equipment: [EntID]
//    let length: LengthID?
//}
//
//// MARK: - Ent
//struct EntID: Codable {
//    let id: Int
//    let name, localizedName: String
//    let image: String
//}
//
//// MARK: - Length
//struct LengthID: Codable {
//    let number: Int
//    let unit: String
//}

