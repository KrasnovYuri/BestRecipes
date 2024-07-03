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
                Text(modelData.dishById.summary)
            }
//            Button {
//                print(URLManager.shared.createURL(id: 645265)!)
//            } label: {
//                Text("1124")
//            }
        }
        .task {
            do {
                try await modelData.fetchDishById3(id: 3)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    TestView()
}
