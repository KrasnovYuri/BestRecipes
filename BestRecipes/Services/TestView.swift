//
//  TestView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct TestView: View {

    // random dishes

//    @StateObject private var modelData = ModelData()
    var check = [1,2,3,4,5]

    var body: some View {
        NavigationView {
            HStack {
                Button {
//                    UserDefaultsService.shared.removeData(forKey: "userName")
//                    UserDefaultsService.shared.removeData(forKey: "userSurname")
//                    UserDefaultsService.shared.save(structs: "Gordon", forKey: "userName")
                    var userDish = DishUserModel()
                    userDish.ingredients.append(UserIngredient())
                    userDish.ingredients.append(UserIngredient())
                    UserDefaultsService.shared.save(structs: userDish, forKey: "Saved")
                    print("here")
                    if let saved: [DishUserModel] = UserDefaultsService.shared.get(forKey: "Saved") {
                        print(saved.count)
//
                    }
                    
                } label: {
                    Text("Button")
                }

            }

        }
        
    }
}

#Preview {
    TestView()
}
