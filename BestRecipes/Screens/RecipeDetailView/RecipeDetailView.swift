//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct RecipeDetailView: View {

    @State var dish: RecipeDetails

    //let analyzedInstructions = dish.analyzedInstructions

    var body: some View {
        ScrollView {
            VStack {

                // title
                Text("How to make \(dish.title)")
                    .font(.custom(Font.semiBold, size: 24))
                //.lineSpacing(2)
                    .padding(.horizontal, 6)

                // dish image
                AsyncImage(url: URL(string: dish.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 343, maxHeight: 200)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 6)

                // raiting
                HStack {
                    RatingElement(bg: false, rating: dish.spoonacularScore)
                    Text("(\(dish.weightWatcherSmartPoints * 10) Reviews)")
                        .font(.custom(Font.light, size: 14))
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .padding(.leading, 6)

                // instructions
                // сделать, если нет инструкций
                VStack(alignment: .leading, spacing: 2) {
                    Text("Instructions")
                        .font(.custom(Font.semiBold, size: 20))
                        .padding(.vertical, 6)

                    ForEach(dish.analyzedInstructions ?? [], id: \.name) { instruction in
                        ForEach(instruction.steps, id: \.number) { step in
                            HStack(alignment: .top) {
                                Text("\(step.number).")
                                    .frame(width: 13)
                                Text(step.step)
                                Spacer()
                            }
                            .font(.custom(Font.light, size: 16))
                            .frame(width: 328)
                        }
                    }
                    .padding(.horizontal, 6)
                }

                HStack {
                    Text("Ingridients")
                        .font(.custom(Font.semiBold, size: 20))
                        .padding(.top, 15)
                        .padding(.bottom, 6)
                    Spacer()
                }
                .padding(.horizontal)

                VStack {
                    ForEach(dish.extendedIngredients, id: \.id) { ingridient in
                        IngridientComponentView(ingridient: ingridient)
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
    }
}

#Preview {
    RecipeDetailView(dish: (RecipeDetails(vegetarian: false, vegan: false, glutenFree: false, dairyFree: true, veryHealthy: true, cheap: false, veryPopular: false, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: 28, gaps: "", preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: 0, healthScore: 2, creditsText: "", sourceName: "", pricePerServing: 0.1,
                                          extendedIngredients: [
                                            ExtendedIngredient(id: 93647, aisle: "Pasta and Rice", image: "pastina.jpg", consistency: "SOLID", name: "sale e pepe", nameClean: "pastina", original: "Sale e pepe", originalName: "Sale e pepe", amount: 1, unit: "serving", meta: [], measures: MeasuresBig(us: Metric(amount: 1, unitShort: "serving", unitLong: "serving"), metric: Metric(amount: 1, unitShort: "serving", unitLong: "serving"))),

                                            ExtendedIngredient(id: 1034053, aisle: "Oil, Vinegar, Salad Dressing", image: "olive-oil.jpg", consistency: "LIQUID", name: "extra virgin olive oil", nameClean: "extra virgin olive oil", original: "Extra virgin olive oil", originalName: "Extra virgin olive oil", amount: 1, unit: "serving", meta: [], measures: MeasuresBig(us: Metric(amount: 1, unitShort: "serving", unitLong: "serving"), metric: Metric(amount: 1, unitShort: "serving", unitLong: "serving")))
                                          ],
                                          id: 2, title: "Carrots, Cauliflower And Anchovies", readyInMinutes: 2, servings: 1, sourceURL: "", image: "https://img.spoonacular.com/recipes/3-556x370.jpg", imageType: "", summary: "", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: "Slice bread into 1cm thick slices: you can toast them or use them as they are. I prefer a soft bread to exalt butter softness. Spread butter with generosity over the bread.If you want to use salted anchovies, rinse them under running water to remove extra salt and divide them into fillets, removing all the bones.",
                                          analyzedInstructions: [
                                            AnalyzedInstruction(name: "Main", steps: [
                                                Step(number: 1, step: "Slice bread into 1cm thick slices: you can toast them or use them as they are. I prefer a soft bread to exalt butter softness.", ingredients: [], equipment: [], length: nil),
                                                Step(number: 2, step: "Spread butter with generosity over the bread.If you want to use salted anchovies, rinse them under running water to remove extra salt and divide them into fillets, removing all the bones. If you use anchovies in oil, just make two fillets out of them and lay them over buttered bread.And now, the final touch: a pickled baby caper in the centre, and - in less than 3 minutes - you have an unusual afternoon break or a fun anti-crisis and anti-panic appetizer for Christmas.", ingredients: [], equipment: [], length: nil),
                                                Step(number: 3, step: "Bake for 20 minutes.", ingredients: [], equipment: [], length: Length(number: 20, unit: "minutes"))])
                                          ],
                                          originalID: nil, spoonacularScore: 65)))
}
