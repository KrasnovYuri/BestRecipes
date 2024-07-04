//
//  SearchDishElement.swift
//  BestRecipes
//
//  Created by Юрий on 04.07.2024.
//

import SwiftUI

struct SearchDishElement: View {
    let title: String
    let image: String
    let rating: Double
    let ingredientsCount: Int
    let cookingTime: Int
    
    @State var bigSize: Bool
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 363, height: 220)
                .cornerRadius(20)
            
            RatingElement(bg: bigSize, rating: rating)
                .offset(x: -140, y: -80)
            
            Spacer()
                .frame(height: 90)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.custom(Font.bold, size: 16))
                    .multilineTextAlignment(.leading)
                    .frame(width: 320, alignment: .bottomLeading)
                
                Text("\(ingredientsCount) Ingredients | \(cookingTime) minutes")
                    .font(.custom(Font.medium, size: 14))
                
            }
            .foregroundColor(.white)
            .offset(x: -5, y: 60)
        }
    }
}

#Preview {
    SearchDishElement(title: "How to make yam & vegetable sauce at home", image: "testImage", rating: 5.0, ingredientsCount: 9, cookingTime: 25, bigSize: true)
}

