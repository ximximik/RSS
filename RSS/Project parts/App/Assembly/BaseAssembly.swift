//
//  BaseAssembly.swift
//  RSS
//
//  Created by Danil Pestov on 14.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Swinject

public protocol BaseAssembly: Assembly { }

public extension BaseAssembly {
    public var container: Container {
        return BaseAssemblyCenter.container
    }
}
