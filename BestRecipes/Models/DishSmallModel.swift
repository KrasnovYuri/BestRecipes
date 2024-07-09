//
//  DishSmallModel.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import Foundation

struct DishSmallModel: Identifiable, Codable {
    var id: Int
    var title: String
    var imageType: String
}

// MARK: - Model DishByCuisine
//https://api.spoonacular.com/recipes/complexSearch?apiKey=856702108d404eedb8ebb7694ab6f67c&cuisine=african&number=1

struct RecipeByCuisine: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}

struct RecipeByCuisineResponse: Codable {
    let results: [RecipeByCuisine]
    let offset: Int
    let number: Int
    let totalResults: Int
}

