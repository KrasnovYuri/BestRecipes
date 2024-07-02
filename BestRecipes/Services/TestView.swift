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

    var body: some View {
        NavigationView {
            HStack {
                Text(modelData.randomDishes.count.description)
            }

        }
        .task {
            do {
                try await modelData.fetchRandomDishes(numberLimit: 2)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    TestView()
}
