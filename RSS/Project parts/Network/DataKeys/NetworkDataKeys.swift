//
// Created by Danil Pestov on 13.10.16.
// Copyright (c) 2016 HOKMT. All rights reserved.
//

enum NetworkKeys {
    
    enum Requests {
        enum Feeds {
            static let lenta = "https://lenta.ru/rss"
            static let gazeta = "https://www.gazeta.ru/export/rss/lenta.xml"
        }
    }
    
    
    enum FeedXML {
        static let rss = "rss"
        
        enum RSS {
            static let channel = "channel"
        }
        
        enum Channel {
            static let item = "item"
        }
        
        enum Item {
            static let title = "title"
            static let description = "description"
            static let link = "link"
            static let date = "pubDate"
            static let dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z" //RFC2822-Format
            
            static let enclosure = "enclosure"
        }
        
        enum Enclosure {
            static let url = "url"
        }
    }
}
