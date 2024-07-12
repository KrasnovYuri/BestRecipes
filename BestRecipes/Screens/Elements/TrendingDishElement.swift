//
//  TrendingDishElement.swift
//  BestRecipes
//
//  Created by Руслан on 04.07.2024.
//

import SwiftUI

struct TrendingDishElement: View {
    @State var bigSize: Bool
    @State var dish: DishLightModel
//    @State var image: Image
    var body: some View {
        VStack {
            ZStack{
                //заменил асинк имедж на кэшд
                CachedAsyncImage(url: URLManager.shared.createURLForImage(id: dish.id, size: .size480), transaction: .init(animation: .easeInOut(duration: 1))) { imageIn in
                    switch imageIn {
                    case .success(let imageIn):
                        imageIn.resizable()
                            .ignoresSafeArea()
                            .frame(width: bigSize ? 343 : 280, height: 180)
                            .scaledToFill()
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
                .clipShape(RoundedRectangle(cornerRadius: 10))
                if bigSize {
                    VStack{
                        Spacer()
                        HStack {
                            Spacer()
                            ZStack() {
                                RoundedRectangle(cornerRadius: 7)
                                    .foregroundStyle(.ultraThinMaterial)
                                    .opacity(0.8)
                                    .frame(width: 41, height: 25)
                                
                                Text("\(dish.readyInMinutes):00")
                                    .font(.custom(Font.medium, size: 13))
                                    .foregroundStyle(.brBlack.opacity(0.9))
                                
                            }
                            .padding(8)
                        }
                    }
                }
            }
            .frame(width: bigSize ? 343 : 280, height: 180)
            HStack {
                Text("How to \(dish.title)")
                    .lineLimit(1)
                    .font(.custom(Font.medium, size: 22))
                    .foregroundStyle(.brBlack)
                Spacer()
            }
            HStack {
                CachedAsyncImage(url: URLManager.shared.createURLForImage(id: dish.id, size: .size90), transaction: .init(animation: .easeInOut)) { imageIn in
                    switch imageIn {
                    case.success(let imageIn):
                        imageIn.resizable()
                            .scaledToFill()
                    default:
                        ZStack {
                            Circle()
                            Image(systemName: "person")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    
                    
                    Text("By \(dish.creditsText)")
                        .font(.custom(Font.light, size: 17))
                        .foregroundStyle(.brGray)
                        .lineLimit(1)
                    Spacer()
                }
                .offset(y: -13)
                
            }
            .frame(width: bigSize ? 343 : 280, height: 254)
        }
    
    }
    

#Preview {
    TrendingDishElement(bigSize: false, dish: DishLightModel())
}

