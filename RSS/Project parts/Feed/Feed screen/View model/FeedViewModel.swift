//
//  FeedFeedViewModel.swift
//  RSS
//
//  Created by Danil Pestov on 14/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import RxSwift
import RxCocoa

//MARK: Enums
public enum FeedViewModelState {
    case normal, loading, error(NSError), successful
}

//MARK: ViewModel
public class FeedViewModel: ReactiveCompatible {
    private let feedAccessor: FeedAccessorProtocol
    private let disposeBag = DisposeBag()
    
    fileprivate let state = Variable<FeedViewModelState>(.normal)
    fileprivate let articles = Variable<[Article]>([])
    
    //MARK: Init
    public init(feedAccessor: FeedAccessorProtocol) {
        self.feedAccessor = feedAccessor
        loadData()
    }
    
    //MARK: Data loading
    public func loadData() {
        guard state.value != .loading else { return }
        
        state.value = .loading
        
        feedAccessor.getFeed()
            .subscribe(
                onNext: { [weak self] articles in
                    guard let sSelf = self else { return }
                    
                    sSelf.articles.value = articles
                    sSelf.state.value = .successful
                },
                onError: { [weak self] error in
                    self?.state.value = .error(error as NSError)
            })
            .addDisposableTo(disposeBag)
    }
}

extension Reactive where Base: FeedViewModel {
    //MARK: Outputs
    public var state: Driver<FeedViewModelState> {
        return base.state.asDriver()
    }
    
    public var articles: Observable<[FeedArticleCellViewModel]> {
        return base.articles.asObservable().mapElement { FeedArticleCellViewModel(article: $0) }
    }
}

extension FeedViewModelState: Equatable { }

public func == (lhs: FeedViewModelState, rhs: FeedViewModelState) -> Bool {
    switch (lhs, rhs) {
    case (.normal, .normal):
        return true
    case (.successful, .successful):
        return true
    case (.loading, .loading):
        return true
    default:
        return false
    }
}
