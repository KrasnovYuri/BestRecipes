//
//  URLManager.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import Foundation

class URLManager {
    static let shared = URLManager() ; private init (){ }

//    let apiKey = apiKeyArray[0]
    let apiKeyArray: [String] = ["85e8df70a57b4a00a21894085314de89", "856702108d404eedb8ebb7694ab6f67c" ,"f03e712b5b384dd49229273db6ffcec2" ,"818a20806ce84b5e9974fdc8ae7fd800" ,"692fc918400e49d4a1397ca8cb1d0e3b"]
    var apiKey : String { apiKeyArray[1] }
    //get dishes by name with autocomplete
    func createURL (_ name: String, numberLimit: Int) -> URL? {
        var urlString = "https://api.spoonacular.com/recipes/autocomplete?apiKey=" + apiKey + "&query=\(name)" + "&number=\(numberLimit)"
        return URL(string: urlString)
    }
    // get dish by id
    func createURL (id: Int) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=" + apiKey)
    }
    //get dishes by cource
    func createURL (course: Course.RawValue, numberLimit: Int) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=" + apiKey + "&course=" + course + "&number=\(numberLimit)")
    }
    //get dishes by cuisine
    func createURL (cuisine: Cuisine.RawValue, numberLimit: Int) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=" + apiKey + "&cuisine=" + cuisine + "&number=\(numberLimit)")
    }
    //get random dishes
    func createURL(numberOfDishes: Int) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/random?apiKey=" + apiKey + "&number=\(numberOfDishes)")
    }
    
    func createURLForImage(id: Int, size: SizeImage) -> URL? {
        URL(string: "https://img.spoonacular.com/recipes/" + "\(id)-" + "\(size.rawValue).jpg")
    }
}

enum SizeImage: String {
    case size90 = "90x90"
    case size240 = "240x150"
    case size312 = "312x150"
    case size314 = "312x231"
    case size480 = "480x360"
    case size556 = "556x370"
    case size636 = "636x393"
}
