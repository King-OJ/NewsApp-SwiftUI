//
//  NewsView.swift
//  NewsApp
//
//  Created by King OJ on 11/07/2024.
//

import SwiftUI

struct NewsView: View {
    
    var newsManager = NewsManager()
    @State private var articles = [NewsResponse.Article]()
    @State private var isLoading = true
    @State private var selectedSegment = 0
    var filteredArticles: [NewsResponse.Article] {
        if selectedSegment == 0 {
            return articles
        }
        else {
            let sentiment = selectedSegment == 1 ? "Positive" : "Negative"
            return articles.filter{ predictSentiment(text: $0.title) == sentiment}
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(content: {
                
                Picker("", selection: $selectedSegment) {
                    Text("All news")
                        .tag(0)
                    Text("Good news")
                        .tag(1)
                    Text("Bad news")
                        .tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                ScrollView {
                    if isLoading {
                        ProgressView()
                    }
                    else {
                        ForEach(filteredArticles) { article in
                            let type = predictSentiment(text: article.title)
                            NavigationLink {
                                ArticleView(article: article)
                            } label: {
                                NewsCardComponent(article: article, type: type ?? "Neutral")
                            }
                        }
                    }
                }
            })
            .navigationTitle("News Feed")
            .preferredColorScheme(.dark)
            .onAppear(perform: {
                newsManager.getNews(category: "general") { newsResponse in
                    articles = newsResponse
                    isLoading = false
                }
            })
        }
    }
}

#Preview {
    NewsView()
}
