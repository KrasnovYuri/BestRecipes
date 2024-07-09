//
//  CategoryDishElement.swift
//  BestRecipes
//
//  Created by Руслан on 04.07.2024.
//

import SwiftUI

struct CategoryDishElement: View {
    @State var dish: DishLightModel
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.brNeutral)
                    .frame(height: 176)
            }
            VStack {
                CachedAsyncImage(url: URLManager.shared.createURLForImage(id: dish.id, size: .size312), transaction: .init(animation: .easeInOut(duration: 1))) { imageIn in
                    switch imageIn {
                    case .success(let imageIn):
                        imageIn.resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 110)
                    default:
                        ZStack {
                            Color(.brNeutral)
                            Image(systemName: "timer")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray)
                                .frame(width: 30)
                        }
                        .clipShape(Circle())
                        .frame(width: 110, height: 110)
                    }
                }
                .clipShape(Circle())
                Spacer()
            }
            VStack {
                Spacer()
                Text(dish.title)
                    .foregroundStyle(.brBlack)
                    .multilineTextAlignment(.center)
                    .font(.custom(Font.medium, size: 14))
                    .lineLimit(2)
                    .padding(.vertical, 10)
                HStack{
                    VStack {
                        HStack {
                            Text("Time: ")
                                .font(.custom(Font.light, size: 12))
                                .foregroundStyle(.brGray)
                            Spacer()
                        }
                        HStack {
                            Text("\(dish.readyInMinutes) Mins")
                                .foregroundStyle(.brBlack)
                                .font(.custom(Font.medium, size: 12))
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
            .padding(15)
        }
        .frame(width: 150, height: 231)
    }
}

#Preview {
    CategoryDishElement(dish: DishLightModel())
}
