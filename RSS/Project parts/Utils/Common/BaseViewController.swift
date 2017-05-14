//
//  BaseViewController.swift
//  Fire
//
//  Created by Danil Pestov on 23.03.17.
//  Copyright © 2017 Danil Pestov. All rights reserved.
//

import UIKit
import RxSwift

public class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    override public func viewDidDisappear(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            if let navigationController = strongSelf.navigationController, navigationController.viewControllers.index(of: strongSelf) != NSNotFound {
            } else {
                strongSelf.disposeBag = DisposeBag()
            }
        }
        super.viewDidDisappear(animated)
    }
}
