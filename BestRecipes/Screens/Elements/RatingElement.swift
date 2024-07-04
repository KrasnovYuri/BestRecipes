//
//  RatingElement.swift
//  BestRecipes
//
//  Created by Руслан on 04.07.2024.
//

import SwiftUI

struct RatingElement: View {
    @State var bg: Bool
    @State var rating: Double
    var body: some View {
        ZStack {
            if bg {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.thinMaterial)
            }
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                Text("\(String(format: "%0.1f",rating/20))")
                    .font(.custom(Font.medium, size: 14))
            }
            .frame(height: 14)
        }
        .frame(width: 58, height: 27)
    }
}

#Preview {
    RatingElement(bg: true, rating: 80.0)
}
