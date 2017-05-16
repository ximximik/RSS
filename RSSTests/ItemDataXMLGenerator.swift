//
//  ItemDataXMLGenerator.swift
//  RSS
//
//  Created by Danil Pestov on 16.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation
import SWXMLHash
@testable import RSS

class ItemDataXMLGenerator {
    
    enum ItemDataElement {
        case title
        case link
        case description
        case date
    }
    
    class func getValidItemData(isHasImage: Bool) -> XMLIndexer {
        var xmlString = "<item>"
        xmlString += "<title>Title</title>"
        xmlString += "<link>http://google.com/</link>"
        xmlString += "<description>Description</description>"
        xmlString += "<pubDate>Mon, 15 May 2017 22:38:00 +0000</pubDate>"
        if isHasImage {
            xmlString += "<enclosure type=\"image/jpeg\" url=\"https://google.com/image.jpg\"></enclosure>"
        }
        xmlString += "</item>"
        return SWXMLHash.parse(xmlString)
    }
    
    class func getInvalidItemData(missedElement: ItemDataElement) -> XMLIndexer {
        var xmlString = "<item>"
        xmlString += missedElement == .title ? "" : "<title>Title</title>"
        xmlString += missedElement == .link ? "" : "<link>http://google.com/</link>"
        xmlString += missedElement == .description ? "" : "<description>Description</description>"
        xmlString += missedElement == .date ? "" : "<pubDate>Mon, 15 May 2017 22:38:00 +0000</pubDate>"
        xmlString += "</item>"
        return SWXMLHash.parse(xmlString)
    }
    
    class func getItemDataWithInvalidDateFormat() -> XMLIndexer {
        var xmlString = "<item>"
        xmlString += "<title>Title</title>"
        xmlString += "<link>http://google.com/</link>"
        xmlString += "<description>Description</description>"
        xmlString += "<pubDate>15 May 2017 22:38:00 +0000</pubDate>"
        xmlString += "</item>"
        return SWXMLHash.parse(xmlString)
    }
}
