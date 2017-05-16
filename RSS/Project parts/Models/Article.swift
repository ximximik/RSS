//
//  Article.swift
//  RSS
//
//  Created by Danil Pestov on 15.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public class Article {
    let title: String
    let descriptionText: String
    let link: URL
    let date: Date
    
    var imageURL: URL?
    var source: FeedSource.Type?
    
    init(title: String, descriptionText: String, link: URL, date: Date) {
        self.title = title
        self.descriptionText = descriptionText
        self.link = link
        self.date = date
    }
}
