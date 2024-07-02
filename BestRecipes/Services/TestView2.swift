//
//  TestView2.swift
//  BestRecipes
//
//  Created by Evgeniy K on 02.07.2024.
//

import SwiftUI

struct TestView2: View {

    // dishes by cuisine

    @StateObject private var modelData = ModelData()

    var body: some View {

        NavigationView {
            HStack {
                ForEach(modelData.recipeByCuisine.results) { dishByCuisine in
                    Text(dishByCuisine.title)
                    Text(dishByCuisine.image)
                }
            }
            .task {
                do {
                    try await modelData.fetchDishByCuisine(cuisine: .african, numberLimit: 1)
                } catch {
                    print(error)
                }
            }
            .navigationTitle("Random Dishes")
        }
    }
}

#Preview {
    TestView2()
}
