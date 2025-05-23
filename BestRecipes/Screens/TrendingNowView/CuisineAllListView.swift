//
//  CuisineAllListView.swift
//  BestRecipes
//
//  Created by Руслан on 09.07.2024.
//

import SwiftUI

struct CuisineAllListView: View {
    @StateObject var modelData: ModelData
    @State var textHeader: String
    @State var isCuisineListViewPushed = false
    var hideToolbar = true
    var cuisineArray = Cuisine.allCases.map {$0.rawValue}
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(cuisineArray, id: \.self ) { cuisine in
                NavigationLink {
                    CuisineListView(modelData: modelData, cuisine: cuisine)
                        .onAppear {
                            isCuisineListViewPushed = false
                        }
                        .onDisappear {
                            isCuisineListViewPushed = true
                        }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 1)
                            .foregroundStyle(.white)
                        HStack {
                            Image("\(cuisine)")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(.white, lineWidth: 2)
                                }
                                .shadow(radius: 3)
                                .padding(.horizontal, 5)
                                .frame(width: 100)
                            Text(cuisine.capitalized)
                                .font(.custom(Font.medium, size: 25))
                                .foregroundStyle(.black)
                            Spacer()
                            Image("Arrow")
                                .padding()
                        }
                    }
                    .frame(width: 370, height: 60)
                    .padding(2)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(textHeader)
                    .font(.custom(Font.semiBold, size: 24))
                    .foregroundColor(.black)
            }
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView()
            }
        }
        .onAppear {
            modelData.tabBarHide = true
        }
        .onDisappear {
            if isCuisineListViewPushed {
                modelData.tabBarHide = false
            }
        }
    }
}

#Preview {
    CuisineAllListView(modelData: ModelData(), textHeader: "Cuisines")
}
