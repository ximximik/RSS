//
//  FeedFeedAssembly.swift
//  RSS
//
//  Created by Danil Pestov on 14/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Swinject 
import SwinjectStoryboard

public class FeedAssembly: BaseAssembly {
    public func assemble(container: Container) {
        //FeedParser
        container.register(FeedParserProtocol.self) { _ in
            FeedParser()
            }
            .inObjectScope(.container)
        
        //FeedRequestPreparer
        container.register(FeedRequestPreparerProtocol.self) { r in
            FeedRequestPreparer()
            }
            .inObjectScope(.container)
        
        //FeedAccessor
        container.register(FeedAccessorProtocol.self) { r in
            FeedAccessor(requestPreparer: r.resolve(FeedRequestPreparerProtocol.self)!,
                            requestProcessor: AssemblyCenter.shared.networkAssembly().networkRequestProcessor(),
                            parser: self.parser(),
                            feedSources: self.feedSources())
            }
            .inObjectScope(.container)
        
        //FeedViewController
        container.register(FeedViewModel.self) { r in
            FeedViewModel(feedAccessor: self.accessor())
        }
        container.storyboardInitCompleted(FeedViewController.self) { r, c in
            c.viewModel = r.resolve(FeedViewModel.self)
        }
    }
    
    public func parser() -> FeedParserProtocol {
        return container.resolve(FeedParserProtocol.self)!
    }
    
    public func accessor() -> FeedAccessorProtocol {
        return container.resolve(FeedAccessorProtocol.self)!
    }
    
    public func feedSources() -> [FeedSource.Type] {
        return [Gazeta.self, Lenta.self]
    }
}
