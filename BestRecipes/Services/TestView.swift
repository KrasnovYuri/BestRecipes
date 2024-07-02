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
            
           
        }
        .task {
            do {
                try await modelData.fetchDishById(id: 645275)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    TestView()
}
