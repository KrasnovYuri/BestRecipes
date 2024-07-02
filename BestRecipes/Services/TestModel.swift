//import Foundation
//
//// MARK: - Welcome
//struct Welcome: Codable {
//    let vegetarian, vegan, glutenFree, dairyFree: Bool
//    let veryHealthy, cheap, veryPopular, sustainable: Bool
//    let lowFodmap: Bool
//    let weightWatcherSmartPoints: Int
//    let gaps: String
//    let preparationMinutes, cookingMinutes: Int?
//    let aggregateLikes, healthScore: Int
//    let creditsText, license, sourceName: String
//    let pricePerServing: Double
//    let extendedIngredients: [ExtendedIngredient]
//    let id: Int
//    let title: String
//    let readyInMinutes, servings: Int
//    let sourceURL: String
//    let image: String
//    let imageType, summary: String
//    let cuisines: [String?]
//    let dishTypes, diets: [String]
//    let occasions: [String?]
//    let instructions: String
//    let analyzedInstructions: []
//    let originalID: Int?
//    let spoonacularScore: Double
//    let spoonacularSourceURL: String
//
//    
//}
//
//// MARK: - ExtendedIngredient
//struct ExtendedIngredient: Codable {
//    let id: Int
//    let aisle, image: String
//    let consistency: Consistency
//    let name, nameClean, original, originalName: String
//    let amount: Double
//    let unit: String
//    let meta: [String]
//    let measures: Measures
//}
//
//enum Consistency: String, Codable {
//    case liquid = "LIQUID"
//    case solid = "SOLID"
//}
//
//// MARK: - Measures
//struct Measures: Codable {
//    let us, metric: Metric
//}
//
//// MARK: - Metric
//struct Metric: Codable {
//    let amount: Double
//    let unitShort, unitLong: String
//}
