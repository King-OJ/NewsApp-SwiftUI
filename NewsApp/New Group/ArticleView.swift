//
//  ArticleView.swift
//  NewsApp
//
//  Created by King OJ on 11/07/2024.
//

import SwiftUI
import Kingfisher

struct ArticleView: View {
    var article: NewsResponse.Article
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading , content: {
                    Text(article.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    KFImage(URL(string: article.urlToImage ?? ""))
                        .resizable()
                        .scaledToFill()
                    
                    Text(article.content ?? "")
                        .padding(.horizontal)
                        .font(.body)
                })
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ArticleView(article: NewsResponse.Article(title: "Breaking News", url: ""))
}
