//
//  FeedFeedParser.swift
//  RSS
//
//  Created by Danil Pestov on 14/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public protocol FeedParserProtocol {     
	func parse(feedData: Data) throws -> [Article]
}

public class FeedParser: FeedParserProtocol {
    
    public func parse(feedData: Data) throws -> [Article] {
        return [Article()]
    }
}
