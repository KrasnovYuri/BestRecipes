//
//  IngridientComponentView.swift
//  BestRecipes
//
//  Created by Evgeniy K on 05.07.2024.
//

import SwiftUI

struct IngridientComponentView: View {
    @State var checkBox = false
    private func createUrlForIngridient(imagePath: String) -> URL? {
        let baseURL = "https://spoonacular.com/cdn/ingredients_100x100/"
        let imagePath = "\(ingridient.image)"
        let imageURL = URL(string: baseURL + imagePath)
        return imageURL
    }

    var ingridient: ExtendedIngredient

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 76)
                .foregroundStyle(.brNeutral)
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.white)
                        .frame(width: 52, height: 52)
                    HStack {
                        AsyncImage (url: createUrlForIngridient(imagePath: ingridient.image)) { image in
                            image
                                .resizable()
                                .scaledToFit()
//                                .frame(width: 52, height: 40)
                                
                        } placeholder: {
                            ProgressView()
                        }
                        .padding(.leading)
                    }
                    .offset(x: -6 )
                    .frame(width: 52, height: 52)
                    
                }
                .padding(.horizontal, 16 )
                
                Text(ingridient.name.capitalized)
                    .font(.custom(Font.medium, size: 16))
                Spacer()
                Text("\(String(format: "%0.1f",ingridient.measures.metric.amount))\(ingridient.measures.metric.unitShort)")
                    .font(.custom(Font.light, size: 14))
                Button {
                    checkBox.toggle()
                } label: {
                    Image("check")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 23)
                        .foregroundStyle(checkBox ? .brRed : .black)
                }
                .padding(19)
            }
        }
        .padding(.horizontal, 16)
        
        
//        VStack {

//        HStack {
//
//            Text(ingridient.aisle)
//                .font(.custom(Font.semiBold, size: 20))
//
//            Spacer()
//        }
//        .clipShape(RoundedRectangle(cornerRadius: 25))
//
//    }
//        .background(.gray)
    }
}

#Preview {

    IngridientComponentView(ingridient: ExtendedIngredient(id: 93647, aisle: "Pasta and Rice", image: "chili-powder.jpg", consistency: "SOLID", name: "sale e pepe", nameClean: "pastina", original: "Sale e pepe", originalName: "Sale e pepe", amount: 1, unit: "serving", meta: [], measures: MeasuresBig(us: Metric(amount: 1, unitShort: "serving", unitLong: "serving"), metric: Metric(amount: 283.495, unitShort: "g", unitLong: "gramm"))))
}
