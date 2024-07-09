//
//  RecentDishElement.swift
//  BestRecipes
//
//  Created by Руслан on 04.07.2024.
//

import SwiftUI

struct RecentDishElement: View {
    @State var dish: DishLightModel
    var body: some View {
        VStack {
            VStack {
                CachedAsyncImage(url: URLManager.shared.createURLForImage(id: dish.id, size: .size480), transaction: .init(animation: .easeInOut(duration: 1))) { imageIn in
                    switch imageIn {
                    case .success(let imageIn):
                        imageIn.resizable()
                            .scaledToFill()
                            .frame(width: 124, height: 124)
                    default:
                        ZStack {
                            Color(.white)
                            Image(systemName: "timer")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray)
                                .frame(width: 50)
                        }
                    }
                }
                .frame(width: 124, height: 124)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical,5)
                Spacer()
            }
            VStack {
                HStack {
                    Text(dish.title)
                        .lineLimit(2)
                        .font(.custom(Font.medium, size: 12))
                        .padding(.horizontal, 3)
                    Spacer()
                }
                HStack {
                    Text(dish.creditsText)
                        .lineLimit(1)
                        .font(.custom(Font.light, size: 8))
                        .padding(.horizontal, 3)
                    Spacer()
                }
                Spacer()
            }
        }
        .frame (width: 130,height: 180)
    }
}

#Preview {
    RecentDishElement(dish: DishLightModel())
}
