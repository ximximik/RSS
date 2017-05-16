//
//  FeedFeedRequestPreparer.swift
//  RSS
//
//  Created by Danil Pestov on 14/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Alamofire

public protocol FeedRequestPreparerProtocol {     
	func getFeed(feedSource: FeedSource.Type) -> DataRequest
}

public class FeedRequestPreparer: FeedRequestPreparerProtocol {
    
    public func getFeed(feedSource: FeedSource.Type) -> DataRequest {
        return Alamofire.request(feedSource.sourceURL, method: .get)
    }
}
