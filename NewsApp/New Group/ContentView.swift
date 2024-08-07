//
//  ContentView.swift
//  NewsApp
//
//  Created by King OJ on 11/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection,
                content:  {
            NewsView().tag(1)
            
            SearchView().tag(2)
            
            SettingsView().tag(3)
        })
        .overlay(alignment: .bottom) {
            CustomTabView(tabSelection: $tabSelection)
        }
    }
}

#Preview {
    ContentView()
}
