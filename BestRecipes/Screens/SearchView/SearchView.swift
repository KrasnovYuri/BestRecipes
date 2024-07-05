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
            ForEach(modelData.searchDishes, id: \.id) { dish in
                SearchDishElement(rating: 5.0, dish: dish)
            }
        }
    }
}

#Preview {
    SearchView(modelData: ModelData(), searchText: .constant(""))
}
