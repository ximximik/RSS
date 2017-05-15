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

    //MARK: Init
    public init(feedAccessor: FeedAccessorProtocol) {
        self.feedAccessor = feedAccessor
    }
}

extension Reactive where Base: FeedViewModel {
    //MARK: Outputs
    public var state: Driver<FeedViewModelState> {
        return base.state.asDriver()
    }
}
