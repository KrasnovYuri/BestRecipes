//
//  TestView3.swift
//  BestRecipes
//
//  Created by Evgeniy K on 02.07.2024.
//

import SwiftUI

struct TestView3: View {

    // dishes by cuisine

    @StateObject private var modelData = ModelData()

    var body: some View {

        NavigationView {
            HStack {
                ForEach(modelData.recipeByCourse.results) { dishByCourse in
                    Text(dishByCourse.title)
                    Text(dishByCourse.image)
                }
            }
            .task {
                do {
                    try await modelData.fetchDishByCources(course: .beverage, numberLimit: 1)
                } catch {
                    print(error)
                }
            }
            .navigationTitle("Random Dishes")
        }
    }
}

#Preview {
    TestView3()
}
