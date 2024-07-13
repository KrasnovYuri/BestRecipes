//
//  AddDishElement.swift
//  BestRecipes
//
//  Created by Руслан on 10.07.2024.
//

import SwiftUI

struct AddDishElement: View {
    @State var serves: Bool
    @Binding var value: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.brNeutral)
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                    Image(serves ? "persons_icon" : "clock_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                }
                .frame(width: 36, height: 36)
                .padding(.horizontal, 16)
                Text(serves ? "Serves" : "Cook time")
                    .font(.custom(Font.semiBold, size: 16))
                Spacer()
                HStack {
                    Button {
                        value += serves ? 1 : 5
                    } label : {
                        ZStack{
                            Circle()
                                .foregroundStyle(.white)
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15)
                                .foregroundStyle(.brBlack)
                        }
                        .frame(width: 36, height: 36)
                    }
                    Text("\(value)\(serves ? "" : " min")")
                        .font(.custom(Font.medium, size: 14))
                        .frame(width: 50)
                    Button {
                        value -= serves ? 1 : 5
                    } label : {
                        ZStack{
                            Circle()
                                .foregroundStyle(.white)
                            Image(systemName: "minus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15)
                                .foregroundStyle(.brBlack)
                        }
                        .frame(width: 36, height: 36)
                    }
                    .disabled(!(value >= 1))
                }
                .padding(.horizontal, 10)
            }
        }
        .frame(height: 60)
    }
}

#Preview {
    AddDishElement(serves: true, value: .constant(0))
}
