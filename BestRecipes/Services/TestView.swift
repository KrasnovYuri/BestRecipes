//
//  TestView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct TestView: View {
    
    @StateObject private var modelData = ModelData()
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(modelData.randomDishes) { dish in
                    Text(dish.title)
                }
            }
            .navigationTitle("Random Dishes")
            .task {
                do {
                    try await modelData.fetchRandomDishes(numberLimit: 3)
                } catch {
                    print(error)
                }
            }
            
        }
        
    }
}

#Preview {
    TestView()
}
