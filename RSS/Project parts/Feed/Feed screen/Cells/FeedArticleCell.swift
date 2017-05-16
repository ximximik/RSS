//
//  FeedArticleCell.swift
//  RSS
//
//  Created by i20 on 16.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import UIKit
import DPTableView
import Kingfisher

public class FeedArticleCell: UITableViewCell, DPTableViewElementCellProtocol {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var articleImageViewWidthConstraint: NSLayoutConstraint!
    
    public static let estimatedHeight: CGFloat = 120
    private static let imageViewWidthDefault: CGFloat = 80
    
    //MARK: Life cycle
    public override func awakeFromNib() {
        super.awakeFromNib()
        resetContent()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        resetContent()
    }
    
    private func resetContent() {
        titleLabel.text = ""
        descriptionLabel.text = ""
        dateLabel.text = ""
        sourceLabel.text = ""
        articleImageView.kf.cancelDownloadTask()
        articleImageView.image = nil
    }
    
    //MARK: Configuration
    public func set(viewModel: FeedArticleCellViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.dateString
        sourceLabel.text = viewModel.source
        
        if viewModel.isExpanded {
            descriptionLabel.text = viewModel.descriptionText
        }
        
        if let imageURL = viewModel.imageURL {
            articleImageView.kf.setImage(with: imageURL)
            articleImageView.kf.indicatorType = .activity
        }
        articleImageView.isHidden = viewModel.imageURL == nil
        articleImageViewWidthConstraint.constant = viewModel.imageURL == nil ? 0 : FeedArticleCell.imageViewWidthDefault
    }
}
