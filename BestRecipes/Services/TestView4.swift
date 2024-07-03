//
//  TestView4.swift
//  BestRecipes
//
//  Created by Evgeniy K on 02.07.2024.
//

import SwiftUI

struct TestView4: View {

    // dishes by ID

    @StateObject private var modelData = ModelData()

    var body: some View {

        NavigationView {
            HStack {
                Text(modelData.dishById.summary)
                //Text(modelData.dishById.title)
            }
            .task {
                do {
                    //try await modelData
                } catch {
                    print(error)
                }
            }
            .navigationTitle("Random Dishes")
        }
    }
}

#Preview {
    TestView4()
}
