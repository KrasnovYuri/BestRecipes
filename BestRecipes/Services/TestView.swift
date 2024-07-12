//
//  TestView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct TestView: View {

    // random dishes

    @StateObject private var modelData = ModelData()
    var check = [1,2,3,4,5]

    var body: some View {
        NavigationView {
            HStack {
                Button {
                  
//                    UserDefaultsService.shared.save(structs: [DishUserModel(), DishUserModel()], forKey: "Saved")
                    if let saved: [DishUserModel] = UserDefaultsService.shared.get(forKey: "Saved") {
                        print(saved.count)
                        print(saved[0].creditsText)
                        print(saved[1].imagePath)
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
