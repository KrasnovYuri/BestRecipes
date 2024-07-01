//
//  URLManager.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import Foundation

class URLManager {
    static let shared = URLManager() ; private init (){ }

    let apiKey = "856702108d404eedb8ebb7694ab6f67c"
    //get dishes by name with autocomplete
    func createURL (_ name: String, numberLimit: Int) -> URL? {
        var urlString = "https://api.spoonacular.com/recipes/autocomplete?apiKey=" + apiKey + "&\(name)" + "&number=\(numberLimit)"
        return URL(string: urlString)
    }
    // get dish by id
    func createURL (id: String) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=" + apiKey)
    }
    //get dishes by cource
    func createURL (course: Course, numberLimit: Int) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=" + apiKey + "&course=" + course.rawValue + "&number=\(numberLimit)")
    }
    //get dishes by cuisine
    func createURL (cuisine: Cuisine, numberLimit: Int) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=" + apiKey + "&cuisine=" + cuisine.rawValue + "&number=\(numberLimit)")
    }
    //get random dishes
    func createURL(numberOfDishes: Int) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/random?apiKey=" + apiKey + "&number=\(numberOfDishes)")
    }
}
