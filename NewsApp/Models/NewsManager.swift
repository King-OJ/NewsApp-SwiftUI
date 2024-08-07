//
//  NewsManager.swift
//  NewsApp
//
//  Created by King OJ on 11/07/2024.
//

import Foundation

class NewsManager {
    private let apiKey = ""
    
    func getNews(category: String, completion: @escaping([NewsResponse.Article]) -> Void ){
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&apiKey=\(apiKey)") else {
            print("Failure to make URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failure to get data")
                return
            }
            
            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(newsResponse.articles)
            }
            catch {
                print("Failed to convert data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getNewsFromSearch(search: String, completion: @escaping([NewsResponse.Article]) -> Void ){
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=\(search)&apiKey=\(apiKey)") else {
            print("Failure to make URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failure to get data")
                return
            }
            
            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(newsResponse.articles)
            }
            catch {
                print("Failed to convert data: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct NewsResponse: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Article]
    
    struct Article: Decodable, Identifiable {
        var title: String
        var description: String?
        var url: String
        var urlToImage: String?
        var content: String?
    }
}

extension NewsResponse.Article {
    var id: String {
        return url;
    }
}
