//
// Created by i20 on 18.10.16.
// Copyright (c) 2016 i20 LLC. All rights reserved.
//

import RxSwift
import Alamofire
import RxAlamofire

public protocol NetworkRequestProcessorProtocol {
    func process<T>(request: DataRequest, handler: @escaping  ((Data) throws -> T)) -> Observable<T>
}

open class NetworkRequestProcessor: NetworkRequestProcessorProtocol {
    
    open func process<T>(request: DataRequest, handler: @escaping ((Data) throws -> T)) -> Observable<T> {
        return request.rx.data()
            .map { data -> T in
                return try handler(data)
        }
    }
    
}
