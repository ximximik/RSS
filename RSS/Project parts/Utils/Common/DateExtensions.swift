//
//  DateExtensions.swift
//  RSS
//
//  Created by i20 on 16.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

extension Date {
    public static func dateString(for article: Article) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: article.date)
    }
}
