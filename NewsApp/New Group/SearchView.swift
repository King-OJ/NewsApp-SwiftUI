//
//  SearchView.swift
//  NewsApp
//
//  Created by King OJ on 11/07/2024.
//

import SwiftUI

struct SearchView: View {
    
    var newsManager = NewsManager()
    
    @State private var selectedGenre = "general"
    @State private var isLoading = true
    @State private var searchText = ""
    @State private var articles: [NewsResponse.Article] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(content: {
                    TextField("Search...", text: $searchText)
                        .padding(.leading, 20)
                    
                    if searchText.isEmpty {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                    }
                    else {
                        Button(action: {
                            searchText = "";
                            updateNewsArticles()
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.gray)
                                .padding(.leading, 8)
                        })
                    }
                })
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.gray.opacity(0.2))
                .clipShape(.rect(cornerRadius: 10))
                
                if searchText == "" {
                    Picker("Picker", selection: $selectedGenre) {
                        Text("General").tag("general")
                        Text("Business").tag("business")
                        Text("Entertainment").tag("entertainment")
                        Text("Sports").tag("sports")
                        Text("Science").tag("science")
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical, 15)
                }
                
                ScrollView {
                    if isLoading {
                        ProgressView()
                    }
                    else {
                        ForEach(articles){
                            article in
                            let type = predictSentiment(text: article.title)
                            NavigationLink {
                                ArticleView(article: article)
                            } label: {
                                NewsCardComponent(article: article, type: type ?? "Neutral")
                            }

                            
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
            .onAppear(perform: updateNewsArticles)
            .onChange(of: selectedGenre) {
                isLoading = true;
                updateNewsArticles();
            }
            .onChange(of: searchText) {
                isLoading = true;
                updateNewsArticlesFromSearch();
            }
        }
    }
    
    private func updateNewsArticles(){
        newsManager.getNews(category: selectedGenre) { newsResponse in
            articles = newsResponse
            isLoading = false
        }
    }
    
    private func updateNewsArticlesFromSearch(){
        newsManager.getNewsFromSearch(search: searchText) { newsResponse in
            articles = newsResponse
            isLoading = false
        }
    }
}

#Preview {
    SearchView()
}
