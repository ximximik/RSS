//
//  FeedStoryboard/StoryboardFeed.swift
//  RSS
//
//  Created by Danil Pestov on 14/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import UIKit
import SwinjectStoryboard

public class StoryboardFeed: Storyboard {
    public override class func storyboard() -> UIStoryboard {
        return AssemblyCenter.createStoryboard(name: "Feed")
    }
    
    public class func feedViewController() -> FeedViewController {
        return FeedViewController.instantiate(storyboard: self)
    }
}
