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
                    print(URLManager.shared.createURL(numberOfPopularDishes: 10)!)
                } label: {
                    Text("dasdfas")
                }

            }

        }
        
    }
}

#Preview {
    TestView()
}
