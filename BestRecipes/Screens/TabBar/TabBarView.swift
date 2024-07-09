//
//  TabBarView.swift
//  BestRecipes
//
//  Created by Руслан on 01.07.2024.
//

import SwiftUI

struct TabBarView: View {
    @Binding var index: Int
    @State var animIndex: Int = 0
    let images = ["TabBarHome","TabBarBookmark","plus","TabBarBell","TabBarProfile"]
    var body: some View {
        ZStack() {
            Rectangle()
                .foregroundStyle(.white)
                .background(.clear).clipShape(CustomShape())
            VStack {
                HStack() {
                    ForEach(images.indices, id: \.self) { ind in
                        if ind == 2 {
                            Button {
                                self.index = ind
                                animIndex = ind
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundStyle(.brRed)
                                    Image(systemName: "plus")
                                        .font(.headline)
                                        .foregroundStyle(.black.opacity(0.8))
                                }
                                .frame(width: 48)
                                .offset(y: -20)
                            }
                        }
                        else {
                            Button {
                                self.index = ind
                                animIndex = ind
                            } label: {
                                Image(images[ind] + "\(animIndex == ind ? "Active" : "Inactive")" )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28)
                                    .padding(20)
                            }
                        }
                    }
                }
                Spacer()
            }
            
        }
        .animation(.easeInOut, value: animIndex)
        .frame(height: 120)
        .shadow(color: .black.opacity(0.1), radius: 15, y: -3 )
    }
}

#Preview {
    TabBarView(index: .constant(0))
}

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = rect.width/2
            path.move(to: CGPoint(x: center - 60, y: 0))
            
            path.addCurve(to: CGPoint(x: center , y: 45), control1: CGPoint(x: center - 30, y: 0), control2: CGPoint(x: center - 30, y: 47))
            path.addCurve(to: CGPoint(x: center + 60, y: 0), control1: CGPoint(x: center + 34, y: 45), control2: CGPoint(x: center + 24 , y: 0))
        }
    }
}
