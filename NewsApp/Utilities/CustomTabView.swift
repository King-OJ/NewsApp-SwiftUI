//
//  CustomTabView.swift
//  NewsApp
//
//  Created by King OJ on 11/07/2024.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    
    let tabBarItems: [(image: String, title: String)] = [
    ("newspaper.fill", "News"),
    ("magnifyingglass", "Search"),
    ("gear", "Settings")
    ]
    
    var body: some View {
        ZStack(content: {
            Capsule()
                .frame(height: 80)
                .foregroundStyle(Color(.secondarySystemBackground))
                .shadow(radius: 2)
            
            HStack(content: {
                ForEach(0..<3) { index in
                    Button(action: {
                        tabSelection = index + 1
                    }, label: {
                        VStack(spacing: 8, content: {
                           Spacer()
                            
                            Image(systemName: tabBarItems[index].image)
                            
                            Text(tabBarItems[index].title)
                                .font(.caption)
                            
                            if index + 1 == tabSelection {
                                Capsule()
                                    .frame(height: 8)
                                    .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                                    .offset(y: 3)
                            }
                            else {
                                Capsule()
                                    .frame(height: 8)
                                    .foregroundStyle(.clear)
                                    .offset(y: 3)
                            }
                        })
                        .foregroundStyle(index + 1 == tabSelection ? .blue : .gray)
                        
                    })
                }
            })
            .frame(height: 80)
            .clipShape(Capsule())
        })
        .padding(.horizontal)
    }
}

#Preview {
    CustomTabView(tabSelection: .constant(1))
}
