//
//  FeedSource.swift
//  RSS
//
//  Created by Danil Pestov on 15.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public protocol FeedSource {
    static var sourceURL: URL { get }
}

public class Gazeta: FeedSource {
    public static var sourceURL: URL {
        return NetworkKeys.Requests.Feeds.gazeta.url!
    }
}

public class Lenta: FeedSource {
    public static var sourceURL: URL {
        return NetworkKeys.Requests.Feeds.lenta.url!
    }
}
