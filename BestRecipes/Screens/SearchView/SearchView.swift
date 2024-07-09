//
//  SearchView.swift
//  BestRecipes
//
//  Created by Юрий on 04.07.2024.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var modelData: ModelData
    @State var searchText: String = ""
    @Binding var active: Bool
    
    
    var body: some View {
        //        SearchBar(searchText: $searchText)
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 0.5)
                        .frame(height: 44)
                        .foregroundStyle( !active ? Color(.brGray) : Color(.brRed))
                    HStack {
                        Image(.search)
                            .padding(.horizontal, 10)
                        
                        TextField("Search recipes", text: $modelData.searchText)
                            .font(.custom(Font.regular, fixedSize: 16))
                            .autocorrectionDisabled()
                        Spacer()
                        if active {
                            Button {
                                UIApplication.shared.endEditing()
                                modelData.searchText = ""
                                active = false
                            } label: {
                                Image(.plus)
                                    .rotationEffect(.degrees(45))
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                }
                .frame(height: 60)
                
                .onTapGesture {
                    active = true
                }
                .onSubmit {
                    reloadInterface()
                }
                .padding()
                Spacer()
                if active {
                    ZStack {
                        ScrollView {
                            ForEach(modelData.searchDishes, id: \.id) { dish in
                                NavigationLink {
                                    RecipeDetailView(id: dish.id)
                                } label: {
                                    SearchDishElement(rating: 5.0, dish: dish)
                                }

                               
                            }
                        }
                        .frame(height: 700)
                    }
                    .animation(.easeInOut(duration: 1), value: active)
                }
            }
            
        }
        .frame(height: active ? 760 : 60 )
    }
    func reloadInterface() {
        Task {
            do {
                try await modelData.fetchSearch()
            }
        }
        
    }
    
}

#Preview {
    SearchView(modelData: ModelData(), active: .constant(true))
}
