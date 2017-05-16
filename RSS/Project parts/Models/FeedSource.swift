//
//  FeedSource.swift
//  RSS
//
//  Created by Danil Pestov on 15.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public protocol FeedSource {
    static var sourceURL: URL! { get }
    static var name: String { get }
}

public class Gazeta: FeedSource {
    public static let sourceURL: URL! = NetworkKeys.Requests.Feeds.gazeta.url
    
    public static let name: String = "Газета.Ru"
}

public class Lenta: FeedSource {
    public static let sourceURL: URL! = NetworkKeys.Requests.Feeds.lenta.url
    
    public static let name: String = "Lenta.ru"
}
