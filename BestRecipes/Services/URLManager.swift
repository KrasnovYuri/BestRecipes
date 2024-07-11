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
    let apiKeyArray: [String] = ["85e8df70a57b4a00a21894085314de89", "856702108d404eedb8ebb7694ab6f67c" ,"f03e712b5b384dd49229273db6ffcec2" ,"818a20806ce84b5e9974fdc8ae7fd800" ,"692fc918400e49d4a1397ca8cb1d0e3b","7bacf3f7cc7e408e9949dd374a8ddad7", "8cf18949852e4f6e82c12342cf83cdc9", "11e930669851467ebda17458e91269a9", "a1a20a4a124747d68fb8dd4f0a957e45", "977e7847d283492bb87bffe3d7256e12", "dbe02e6c827948cab1164a95cab41203", "4746f1a7e1ad4876996cd8e626b05ce4", "b6dbf7fcf5094745ac11204866483713","f53c3c540feb41b08450248060e8cd77", "3df4748a170f45ce9c519d7371a16480", "dbf6bff012ad44bfad9b5b5582c6f963","ec302cd3ae2e439b9558cc79d26c5efa","8fb252dbc5db455aa22b7c3f5d0a952b","1d725eb876444268ae0f53d1bcbe8b44"]
    
    private var apiKey : String { apiKeyArray[12] }
    
    //get dishes by name with autocomplete
    func createURL (_ name: String, numberLimit: Int) -> URL? {
        URL(string:"https://api.spoonacular.com/recipes/autocomplete?apiKey=" + apiKey + "&query=\(name)" + "&number=\(numberLimit)" + "&sort=popularity")
    }
    // get dish by id
    func createURL (id: Int) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=" + apiKey)
    }
    //get dishes by food category
    func createURL (foodCategory: FoodCategory.RawValue, numberLimit: Int) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=" + apiKey + "&type=" + foodCategory + "&number=\(numberLimit)" + "&sort=popularity")
    }
    //get dishes by cuisine
    func createURL (cuisine: Cuisine.RawValue, numberLimit: Int) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/random?apiKey=" + apiKey + "&include-tags=" + cuisine + "&number=\(numberLimit)" + "&sort=popularity" )
    }
    //get random dishes
    func createURL(numberOfDishes: Int) -> URL? {
        URL(string: "https://api.spoonacular.com/recipes/random?apiKey=" + apiKey + "&number=\(numberOfDishes)")
    }
    
    // get popular dishes
    func createURL(numberOfPopularDishes: Int) -> URL? {
        URL(string:"https://api.spoonacular.com/recipes/random?apiKey=" + apiKey + "&number=\(numberOfPopularDishes)" + "&sort=popularity")
    }
    //get url for image by id
    func createURLForImage(id: Int, size: SizeImage) -> URL? {
        URL(string: "https://img.spoonacular.com/recipes/" + "\(id)-" + "\(size.rawValue).jpg")
    }
    //get URL for bulk ingredients
    func createURLBulk(id:[Int]) -> URL? {
        var arrayOfDishes = ""
        for dish in id.enumerated() {
            arrayOfDishes.append( dish.offset == 0 ? "\(dish.element)" : ",\(dish.element)")
        }
        return URL(string: "https://api.spoonacular.com/recipes/informationBulk?" + "ids=\(arrayOfDishes)"  + "&apiKey=" + apiKey )
    }
    
    func printCount() {
        print(apiKeyArray.count)
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
