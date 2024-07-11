//
//  StartView.swift
//  BestRecipes
//
//  Created by Denis Evdokimov on 7/6/24.
//

import SwiftUI

struct StartView: View {
    @State var onboadingOn: Bool = false
    var body: some View {
            ZStack {
                    Image("OnboardingMain")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                VStack {
                    Label(
                        title: { Text("100k+")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                + Text("Premium recipes")
                                .foregroundColor(.white)
                                },
                        icon: { Image(systemName: "star.fill") }
                    )
                    .padding(.top, 20)
                    Spacer()
                    VStack(alignment: .center) {
                        VStack {
                            Text("Best")
                            Text("Recipe")
                        }
                        .font(.custom(Font.bold, size: 56))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        Text("Find best recipes for cooking")
                            .font(.custom(Font.regular, size: 16))
                            .foregroundColor(.white)
                    }
                    .frame(width: 300)
                   
                    Button {
                        onboadingOn = true
                    } label: {
                        Text("Get started")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding([.all], 20)
                            .padding([.leading, .trailing], 20)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.5))
            }
            .fullScreenCover(isPresented: $onboadingOn){
                OnboardingView()
            }
            .transaction({ transaction in
              transaction.disablesAnimations = true
              transaction.animation = .linear(duration: 0.5)
            })
            
        }
    }

#Preview {
    StartView()
}

struct CustomTransition: ViewModifier {
    let isPresented: Bool
    let animation: Animation
    
    func body(content: Content) -> some View {
        content
            .opacity(isPresented ? 1 : 0)
            .offset(y: isPresented ? 0 : UIScreen.main.bounds.height)
            .animation(animation, value: isPresented)
    }
}
