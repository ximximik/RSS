//
//  FeedFeedParser.swift
//  RSS
//
//  Created by Danil Pestov on 14/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation
import SWXMLHash

public protocol FeedParserProtocol {
    func parse(feedData: Data) throws -> [Article]
}

public class FeedParser: FeedParserProtocol {
    
    public func parse(feedData: Data) throws -> [Article] {
        let xml = SWXMLHash.parse(feedData)
        let channel = xml[NetworkKeys.FeedXML.rss][NetworkKeys.FeedXML.RSS.channel]
        let items = try channel[NetworkKeys.FeedXML.Channel.item].all.map { try parse(feedItemXML: $0) }
        return items
    }
    
    public func parse(feedItemXML: XMLIndexer) throws -> Article {
        guard let title = try? feedItemXML[NetworkKeys.FeedXML.Item.title].value() as String,
            let description = try? feedItemXML[NetworkKeys.FeedXML.Item.description].value() as String,
            let linkString = try? feedItemXML[NetworkKeys.FeedXML.Item.link].value() as String,
            let link = linkString.url,
            let dateString = try? feedItemXML[NetworkKeys.FeedXML.Item.date].value() as String else {
                throw NSError.invalidResponse
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = NetworkKeys.FeedXML.Item.dateFormat
        dateFormatter.locale = Locale(identifier: "en")
        
        guard let date = dateFormatter.date(from: dateString) else {
            throw NSError.invalidResponse
        }
        
        let imageURLString = try? feedItemXML[NetworkKeys.FeedXML.Item.enclosure].value(ofAttribute: NetworkKeys.FeedXML.Enclosure.url) as String
        let imageURL: URL? = imageURLString?.url
        
        
        let article = Article(title: title, descriptionText: description, link: link, date: date, imageURL: imageURL)
        
        return article
    }
}
