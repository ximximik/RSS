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
import DPTableView

public class FeedViewController: BaseViewController {
    @IBOutlet private weak var tableView: DPTableView!
    private var refreshControl: UIRefreshControl!
    
    public var viewModel: FeedViewModel!
    
    //MARK: Lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupTableView()
    }
    
    //MARK: Setups
    private func setupBindings() {
        viewModel.rx.state
            .drive(onNext: { [weak self] state in
                guard let sSelf = self else { return }
                
                switch state {
                case .loading:
                    sSelf.showStatusHud()
                case .normal:
                    sSelf.hideStatusHud()
                case .successful:
                    sSelf.hideStatusHud()
                    sSelf.refreshControl?.endRefreshing()
                case .error(let error):
                    sSelf.hideStatusHud()
                    sSelf.showAlert(with: error)
                    sSelf.refreshControl?.endRefreshing()
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    private func setupTableView() {
        setupRefreshControl()
        
        tableView.noItemsText = Localization.Feed.emptyText
        
        tableView.setup(cellType: FeedArticleCell.self, viewModels: viewModel.rx.articles)
        
        tableView.rx
            .modelSelected(FeedArticleCell.ViewModel.self)
            .subscribe(onNext: { viewModel in
                viewModel.isExpanded = !viewModel.isExpanded
            })
            .addDisposableTo(disposeBag)
        
        tableView.rx
            .itemSelected
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
            })
            .addDisposableTo(disposeBag)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: Localization.Feed.reloadText)
        refreshControl.addTarget(self, action: #selector(FeedViewController.refreshData), for: UIControlEvents.valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
    }
    
    public func refreshData() {
        viewModel.loadData()
    }
}
