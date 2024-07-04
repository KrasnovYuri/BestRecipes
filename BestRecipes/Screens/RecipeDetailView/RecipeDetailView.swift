//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct RecipeDetailView: View {

    @ObservedObject var modelData = ModelData()
    @Binding var dish: RecipeDetails

    //let analyzedInstructions = dish.analyzedInstructions

    var body: some View {
        ScrollView {
            VStack {

                // title
                Text("How to make \(dish.title)")
                    .font(.custom(Font.semiBold, size: 24))
                    .lineSpacing(4)
                    .padding(.horizontal, 6)

                // dish image
                    AsyncImage(url: URL(string: dish.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: 215)
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 6)

                // raiting

                    Text("300 Reviews")

                // instructions
                VStack(alignment: .leading, spacing: 2) {
                    Text("Instructions")
                        .font(.custom(Font.semiBold, size: 20))
                        .padding(.vertical, 6)

                    ForEach(dish.analyzedInstructions ?? [], id: \.name) { instruction in
                        ForEach(instruction.steps, id: \.number) { step in
                            HStack(alignment: .top) {
                                Text("\(step.number).")
                                Text(step.step)
                            }
                            .font(.custom(Font.light, size: 16))
                        }
                    }
                }
                .padding(.horizontal, 6)
            }
            .padding()
        }
    }
}


#Preview {
    RecipeDetailView(dish: .constant(RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 1, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 0, healthScore: 2, creditsText: "", sourceName: "", pricePerServing: 0.1, extendedIngredients: [], id: 2, title: "Carrots, Cauliflower And Anchovies", readyInMinutes: 2, servings: 1, sourceURL: "", image: "https://img.spoonacular.com/recipes/3-556x370.jpg", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: "Slice bread into 1cm thick slices: you can toast them or use them as they are. I prefer a soft bread to exalt butter softness. Spread butter with generosity over the bread.If you want to use salted anchovies, rinse them under running water to remove extra salt and divide them into fillets, removing all the bones. If you use anchovies in oil, just make two fillets out of them and lay them over buttered bread.And now, the final touch: a pickled baby caper in the centre, and - in less than 3 minutes - you have an unusual afternoon break or a fun anti-crisis and anti-panic appetizer for Christmas.",
                                                   analyzedInstructions: [
                                                    AnalyzedInstruction(name: "Main", steps: [
                                                        Step(number: 1, step: "Slice bread into 1cm thick slices: you can toast them or use them as they are. I prefer a soft bread to exalt butter softness.", ingredients: [], equipment: [], length: nil),
                                                        Step(number: 2, step: "Spread butter with generosity over the bread.If you want to use salted anchovies, rinse them under running water to remove extra salt and divide them into fillets, removing all the bones. If you use anchovies in oil, just make two fillets out of them and lay them over buttered bread.And now, the final touch: a pickled baby caper in the centre, and - in less than 3 minutes - you have an unusual afternoon break or a fun anti-crisis and anti-panic appetizer for Christmas.", ingredients: [], equipment: [], length: nil),
                                                        Step(number: 3, step: "Bake for 20 minutes.", ingredients: [], equipment: [], length: Length(number: 20, unit: "minutes"))])
                                                   ],
                                                   originalID: nil, spoonacularScore: 0.2)))
}
