//
//  Article.swift
//  RSS
//
//  Created by Danil Pestov on 15.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public struct Article {
    let title: String
    let descriptionText: String
    let link: URL
    let date: Date
    let imageURL: URL?
}
