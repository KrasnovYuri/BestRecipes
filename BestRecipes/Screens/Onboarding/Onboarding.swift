//
//  ContentView.swift
//  BestRecipes
//
//  Created by Юрий on 30.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    @State var selectedPage = 0
    var body: some View {
        TabView(selection: $selectedPage) {

            PageView(selectedPage: $selectedPage, imageName: "Onboarding1", title: "Recipes from all ", subtitle: "over the World", buttonTitle: "Continue").tag(0)

               
            PageView(selectedPage: $selectedPage, imageName: "Onboarding2", title: "Recipes with ", subtitle: "each and every detail", buttonTitle: "Continue").tag(1)

            PageView(selectedPage: $selectedPage, imageName: "Onboarding3", title: "Cook it now or ", subtitle: "save it for later", buttonTitle: "Start Cooking").tag(2)

        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
    }
}

struct PageView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @Binding var selectedPage: Int
    var imageName: String
    var title: String
    var subtitle: String
    var buttonTitle: String
    
    var body: some View {
        ZStack {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack() {
                    Spacer()
                    VStack(alignment: .center) {
                        Text(title)
                            .foregroundColor(.white)
                        Text(subtitle)
                            .foregroundColor(.brGold)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width)
                    .font(.custom(Font.bold, size: 40))
                    HStack{
                        ForEach(0..<3) { num in
                            Rectangle()
                                .fill(selectedPage == num ? Color.brGold : Color.white)
                                .cornerRadius(10)
                                .frame(width: 50, height: 10)
                              
                        }
                    }
                    .padding()
                    Button(action: {
                        nextView()
                    }) {
                        Text(buttonTitle)
                            .font(.custom(Font.bold, size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal, 30)
                            .background(Color.red)
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 10)
                    if selectedPage != 2 {
                        Button {
                            isOnboarding =  false
                        } label: {
                            Text("Skip")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.bottom, 30)
                .ignoresSafeArea()
                .background(Color.black.opacity(0.5))
        }
     
    }
}

extension PageView {
    func nextView() {
        if selectedPage == 2 {
            isOnboarding =  false
        } else {
            withAnimation {
                selectedPage += 1
            }
        }
      
    }
}

struct ContentView: View {
    var body: some View {
        OnboardingView()
    }
}

#Preview {
    ContentView()
}
