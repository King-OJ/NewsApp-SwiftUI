//
//  NewsClassifier.swift
//  NewsApp
//
//  Created by King OJ on 06/08/2024.
//

import Foundation
import CoreML

func predictSentiment(text: String) -> String? {
    do {
        let config = MLModelConfiguration()
        let newsClassifier = try MyTextMLmodel(configuration: config)
        let prediction = try newsClassifier.prediction(text: text)
        return prediction.label
    } catch {
        print("Failed to make prediction: \(error.localizedDescription)")
        return nil;
    }
}
