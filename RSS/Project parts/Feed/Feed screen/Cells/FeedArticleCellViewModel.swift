//
//  FeedArticleCellViewModel.swift
//  RSS
//
//  Created by i20 on 16.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public class FeedArticleCellViewModel {
    let title: String
    let dateString: String
    let imageURL: URL?
    let descriptionText: String
    let source: String
    
    var isExpanded: Bool = false
    
    public init(article: Article) {
        self.title = article.title
        self.descriptionText = article.descriptionText.trimmingCharacters(in: .whitespacesAndNewlines)
        self.imageURL = article.imageURL
        self.dateString = Date.dateString(for: article)
        self.source = article.source?.name ?? ""
    }
    
}
