//
// Created by Danil Pestov on 17.10.16.
// Copyright (c) 2016 HOKMT. All rights reserved.
//

import Swinject
import SwinjectStoryboard

open class BaseAssemblyCenter {
    private static let _shared = BaseAssemblyCenter()
    open class var shared: BaseAssemblyCenter {
        return _shared
    }
    
    private let assembler: Assembler
    
    public static var container: Container {
        return SwinjectStoryboard.defaultContainer
    }
    
    open var assemblies: [Assembly] {
        return []
    }
    
    init() {
        assembler = Assembler(container: BaseAssemblyCenter.container)
        assembler.apply(assemblies: assemblies)
    }
    
    //Storyboard
    public static func createStoryboard(name: String) -> UIStoryboard {
        return SwinjectStoryboard.create(name: name, bundle: nil, container: container)
    }
}
