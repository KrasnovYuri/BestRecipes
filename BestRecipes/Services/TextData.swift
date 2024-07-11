//
//  TextData.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import Foundation

enum Cuisine: String, CaseIterable {
    case african
    case asian
    case american
    case british
    case cajun
    case caribbean
    case chinese
    case easternEuropean
    case european
    case french
    case german
    case greek
    case indian
    case irish
    case italian
    case japanese
    case jewish
    case korean
    case latinAmerican
    case mediterranean
    case mexican
    case middleEastern
    case nordic
    case southern
    case spanish
    case thai
    case vietnamese
}

enum Course: String, CaseIterable {
    case mainCourse
    case sideDish
    case dessert
    case appetizer
    case salad
    case bread
    case breakfast
    case soup
    case beverage
    case sauce
    case marinade
    case fingerfood
    case snack
    case drink
    
}

enum FoodCategory: String, CaseIterable {
    case mainCourse = "Main Course"
    case sideDish = "Side Dish"
    case dessert = "Dessert"
    case appetizer = "Appetizer"
    case salad = "Salad"
    case bread = "Bread"
    case breakfast = "Breakfast"
    case soup = "Soup"
    case beverage = "Beverage"
    case sauce = "Sauce"
    case marinade = "Marinade"
    case fingerfood = "Finger Food"
    case snack = "Snack"
    case drink = "Drink"
}

enum Unit: String, CaseIterable {
    case gr
    case ml
    case sp
}
