//
//  SearchView.swift
//  BestRecipes
//
//  Created by Юрий on 04.07.2024.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var modelData: ModelData
    @Binding var searchText: String
    
    
    var body: some View {
        ScrollView {
            SearchBar(searchText: $searchText)
                .padding()
            ForEach(modelData.trendingDishes, id: \.id) { dish in
                SearchDishElement(title: "How to make yam & vegetable sauce at home", image: "testImage", rating: 5.0, ingredientsCount: 9, cookingTime: 25, bigSize: true)
            }
        }
    }
}

#Preview {
    SearchView(modelData: ModelData(), searchText: .constant(""))
}
