//
//  CuisineAllListView.swift
//  BestRecipes
//
//  Created by Руслан on 09.07.2024.
//

import SwiftUI

struct CuisineAllListView: View {
    var cuisineArray = Cuisine.allCases.map {$0.rawValue}
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Text("Cuisine")
                        .font(.custom(Font.bold, size: 25))
                        .padding()
                    Spacer()
                }
                ScrollView(showsIndicators: false) {
                    ForEach(cuisineArray, id: \.self ) { cuisine in
                        NavigationLink {
                            CuisineListView(cuisine: cuisine)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.linearGradient(colors: [.brGray, .white], startPoint: UnitPoint(x: 0, y: 30), endPoint: UnitPoint(x: 1, y: 30)))
                                HStack {
                                    //                                Image(systemName: "arrowshape.right.fill")
                                    //                                    .resizable()
                                    //                                    .scaledToFit()
                                    //                                    .clipShape(Circle())
                                    //                                    .overlay {
                                    //                                        Circle().stroke(.white, lineWidth: 2)
                                    //                                    }
                                    //                                    .shadow(radius: 3)
                                    Spacer()
                                    Text(cuisine)
                                        .font(.custom(Font.medium, size: 25))
                                        .foregroundStyle(.black)
                                    Spacer()
                                    
                                }
                            }
                            
                            .frame(width: 370, height: 60)
                            .padding(2)
                        }
                        
                        
                    }
                }
            }
        }
    }
}

#Preview {
    CuisineAllListView()
}
