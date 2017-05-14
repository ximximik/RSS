//
// Created by i20 on 13.10.16.
// Copyright (c) 2016 i20 LLC. All rights reserved.
//
import Swinject

public class NetworkAssembly: BaseAssembly {
    
    public func assemble(container: Container) {
        //NetworkNetworkRequestProcessor
        container.register(NetworkRequestProcessorProtocol.self) { r in
            NetworkRequestProcessor()
            }
            .inObjectScope(.container)
    }
    
    public func networkRequestProcessor() -> NetworkRequestProcessorProtocol {
        return container.resolve(NetworkRequestProcessorProtocol.self)!
    }
}
