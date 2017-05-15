//
//  RSSTests.swift
//  RSSTests
//
//  Created by Danil Pestov on 14.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import XCTest
import SWXMLHash
@testable import RSS

class FeedParserTests: XCTestCase {
    private var parser: FeedParser!
    
    override func setUp() {
        super.setUp()
        parser = FeedParser()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidItemDataWithImage() {
        // given
        let xml = ItemDataXMLGenerator.getValidItemData(isHasImage: true)
        var error: Error? = nil
        var article: Article? = nil
        
        // when
        do {
            article = try parser.parse(feedItemXML: xml[NetworkKeys.FeedXML.Channel.item])
        } catch let catchedError {
            error = catchedError
        }
        
        // then
        XCTAssertNotNil(article)
        XCTAssertNil(error)
        XCTAssertEqual(article?.title, "Title")
        XCTAssertEqual(article?.descriptionText, "Description")
        XCTAssertEqual(article?.date.timeIntervalSince1970, 1494887880) //Mon, 15 May 2017 22:38:00 +0000 in timestamp
        XCTAssertEqual(article?.link, "http://google.com/".url)
        XCTAssertEqual(article?.imageURL, "https://google.com/image.jpg".url)
    }
    
    func testValidItemDataWithoutImage() {
        // given
        let xml = ItemDataXMLGenerator.getValidItemData(isHasImage: false)
        var error: Error? = nil
        var article: Article? = nil
        
        // when
        do {
            article = try parser.parse(feedItemXML: xml[NetworkKeys.FeedXML.Channel.item])
        } catch let catchedError {
            error = catchedError
        }
        
        // then
        XCTAssertNotNil(article)
        XCTAssertNil(error)
        XCTAssertEqual(article?.title, "Title")
        XCTAssertEqual(article?.descriptionText, "Description")
        XCTAssertEqual(article?.date.timeIntervalSince1970, 1494887880) //Mon, 15 May 2017 22:38:00 +0000 in timestamp
        XCTAssertEqual(article?.link, "http://google.com/".url)
        XCTAssertNil(article?.imageURL)
    }
    
    func testItemDataWithInvalidDateFormat() {
        // given
        let xml = ItemDataXMLGenerator.getItemDataWithInvalidDateFormat()
        var error: Error? = nil
        var article: Article? = nil
        
        // when
        do {
            article = try parser.parse(feedItemXML: xml[NetworkKeys.FeedXML.Channel.item])
        } catch let catchedError {
            error = catchedError
        }
        
        // then
        XCTAssertNil(article)
        XCTAssertNotNil(error)
        XCTAssertEqual((error as NSError?)?.domain, NSError.invalidResponse.domain)
    }
    
    func testInvalidItemData() {
        validateInvalidItemData(missedElement: .title)
        validateInvalidItemData(missedElement: .description)
        validateInvalidItemData(missedElement: .date)
        validateInvalidItemData(missedElement: .link)
    }
    
    // Helpers
    func validateInvalidItemData(missedElement: ItemDataXMLGenerator.ItemDataElement) {
        // given
        let xml = ItemDataXMLGenerator.getInvalidItemData(missedElement: missedElement)
        var error: Error? = nil
        var article: Article? = nil
        
        // when
        do {
            article = try parser.parse(feedItemXML: xml[NetworkKeys.FeedXML.Channel.item])
        } catch let catchedError {
            error = catchedError
        }
        
        // then
        XCTAssertNil(article)
        XCTAssertNotNil(error)
        XCTAssertEqual((error as NSError?)?.domain, NSError.invalidResponse.domain)
    }
}
