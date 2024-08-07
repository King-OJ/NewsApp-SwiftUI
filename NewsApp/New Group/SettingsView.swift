//
//  SettingsView.swift
//  NewsApp
//
//  Created by King OJ on 11/07/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @StateObject var purchaseVM = PurchaseViewModel()
    @AppStorage("purchase") var purchased = false
    
    var body: some View {
        NavigationStack {
            if purchased == false {
                VStack {
                    Text("Subscribe to access settings.")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    Spacer()
                    
                    Image(systemName: "lock.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding(.bottom)
                    
                    Text("Unlock all features with a subscription.")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    
                    HStack(spacing: 30) {
                        Button(action: {
                            Task {
                               let viewModel = purchaseVM
                                await buy(product: viewModel.subscriptions[1])
                            }
                        }, label: {
                            VStack{
                                Text("Monthly")
                                    .font(.headline)
                                
                                Text("3.99/Month")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        })
                        
                        Button(action: {
                            Task {
                                await buy(product: purchaseVM.subscriptions.first!)
                            }
                        }, label: {
                            VStack{
                                Text("Yearly")
                                    .font(.headline)
                                
                                Text("39.99/year")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        })
                    }
                    
                    Spacer()
                    
                    Text("By subscribing, you agree to the terms of use and privacy policy!")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .padding(.bottom)
                }
                .padding()
                .preferredColorScheme(.dark)
            }
            else {
                Form {
                    Section("About") {
                        Text("This app keeps you up to date on the latest news. Premium content coming soon.")
                    }
                }
                .navigationTitle("Settings")
                .preferredColorScheme(.dark)
            }
        }
        .task {
            if purchaseVM.purchasedSubscriptions.isEmpty {
                purchased = false
            }
            else {
                purchased = true
            }
        }
    }
    
    func buy(product: Product) async {
        do {
            if try await purchaseVM.purchase(product) != nil {
                purchased = true
            }
        } catch {
            print("Purchase failed")
        }
    }
}

#Preview {
    SettingsView()
}
