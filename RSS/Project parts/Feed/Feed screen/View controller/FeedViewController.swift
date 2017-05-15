//
//  FeedFeedViewController.swift
//  RSS
//
//  Created by Danil Pestov on 14/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class FeedViewController: UIViewController {
    private var disposeBag = DisposeBag()
    public var viewModel: FeedViewModel!

    //MARK: Lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    //MARK: Setups
    private func setupBindings() {
        viewModel.rx.state
            .drive(onNext: { state in
                switch state {
                case .loading:
                    self.showHud()
                case .normal:
                    self.hideHud()
                case .successful:
                    self.hideHud()
                case .error(let error):
                    self.hideHud()
                    self.showAlert(with: error)
                }
            })
            .addDisposableTo(disposeBag)
    }
}
