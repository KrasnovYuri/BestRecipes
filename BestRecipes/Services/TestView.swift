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
    var check = 1

    var body: some View {
        NavigationView {
            HStack {
                Button {
                    print(URLManager.shared.createURL("chick", numberLimit: 3)!)
                    
                
                } label: {
                    Text("dasdfas")
                }
//                .task {
//                    do {
//                        try await modelData.fetchDishByCuisine(cuisine: Cuisine.cajun.rawValue, numberLimit: 5)
//                    } catch {
//                        
//                    }
//                }
            }

        }
        
    }
}

#Preview {
    TestView()
}
