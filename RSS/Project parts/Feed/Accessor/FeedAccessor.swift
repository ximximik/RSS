//
//  FeedFeedAccessor.swift
//  RSS
//
//  Created by Danil Pestov on 14/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation
import RxSwift
public protocol FeedAccessorProtocol {
    func getFeed() -> Observable<[Article]>
}

public class FeedAccessor: FeedAccessorProtocol {
    private let requestPreparer: FeedRequestPreparerProtocol
    private let requestProcessor: NetworkRequestProcessorProtocol
    private let parser: FeedParserProtocol
    private var disposeBag = DisposeBag()
    private let feedSources: [FeedSource.Type]
    
    init(requestPreparer: FeedRequestPreparerProtocol,
         requestProcessor: NetworkRequestProcessorProtocol,
         parser: FeedParserProtocol,
         feedSources: [FeedSource.Type]) {
        self.requestPreparer = requestPreparer
        self.requestProcessor = requestProcessor
        self.parser = parser
        self.feedSources = feedSources
    }
    
    public func getFeed() -> Observable<[Article]> {
        let requests = feedSources.map { getFeed(feedSource: $0) }
        return Observable
            .combineLatest(requests) { [weak self] articlesArrays -> [Article] in
                return self?.flatAndSort(articlesArrays: articlesArrays) ?? []
                
        }
    }
    
    public func getFeed(feedSource: FeedSource.Type) -> Observable<[Article]> {
        return requestProcessor
            .process(request: requestPreparer.getFeed(feedSource: feedSource),
                     handler: parser.parse(feedData:))
            .mapElement { article in
                article.source = feedSource
                return article
        }
    }
    
    //MARK: Helpers
    public func flatAndSort(articlesArrays: [[Article]]) -> [Article] {
        let allArticles = articlesArrays.flatMap { $0 }
        let sortedArticles = allArticles.sorted(by: { $0.date.compare($1.date) == ComparisonResult.orderedDescending })
        return sortedArticles
    }
}
