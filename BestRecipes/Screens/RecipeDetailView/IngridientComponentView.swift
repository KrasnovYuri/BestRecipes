//
//  IngridientComponentView.swift
//  BestRecipes
//
//  Created by Evgeniy K on 05.07.2024.
//

import SwiftUI

struct IngridientComponentView: View {

    private func createUrlForIngridient(imagePath: String) -> URL? {
        let baseURL = "https://spoonacular.com/cdn/ingredients_100x100/"
        let imagePath = "\(ingridient.image)"
        let imageURL = URL(string: baseURL + imagePath)
        return imageURL
    }

    var ingridient: ExtendedIngredient

    var body: some View {
        VStack {

        HStack {
            AsyncImage(url: createUrlForIngridient(imagePath: ingridient.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } placeholder: {
                ProgressView()
            }
            .padding(.leading)

            Text(ingridient.aisle)
                .font(.custom(Font.semiBold, size: 20))

            Spacer()
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))

    }
        .background(.gray)
    }
}

#Preview {

    IngridientComponentView(ingridient: ExtendedIngredient(id: 93647, aisle: "Pasta and Rice", image: "pastina.jpg", consistency: "SOLID", name: "sale e pepe", nameClean: "pastina", original: "Sale e pepe", originalName: "Sale e pepe", amount: 1, unit: "serving", meta: [], measures: MeasuresBig(us: Metric(amount: 1, unitShort: "serving", unitLong: "serving"), metric: Metric(amount: 1, unitShort: "serving", unitLong: "serving"))))
}
