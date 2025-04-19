//
//  FinalPageContent.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 16/04/25.
//

import SwiftUI

struct FinalContentView: View {
    @State private var navigatingToCategoryPage = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.purple.opacity(0.3), Color.purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 500)
                    Spacer()
                }
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    VStack(spacing: 30) {

                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 60, height: 50)
                                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                            
                            Image(systemName: CommonImageConstants.mainPageImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.black)
                        }
                        VStack {

                            Text(CommonConstants.thanksHeader)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text(CommonConstants.shoppingHeader)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        Button(action: {
                            navigatingToCategoryPage = true
                        }) {
                            Text(CommonConstants.orderNow)
                                .font(.system(size: 16, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(Color(.systemGray6))
                                .cornerRadius(12)
                        }
                        .navigationDestination(isPresented: $navigatingToCategoryPage) {
                            CategoryContentView()
                                    }
                        Button(action: {
                            exit(0)
                        }) {
                            Text(CommonConstants.close)
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                        }
                    }
                    .padding(24)
                    .frame(height: 450)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
                    .padding(.horizontal, 0)
                    .padding(.bottom, 0)
                }
            }
        }.onAppear() {
            CommonVariables.shoppingCartListCount = 0
            CommonVariables.shoppingCartListItem = [:]
            CommonVariables.totalcost = 0.0
        }
    }
}

