//
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation
import Swinject

public class AssemblyCenter: BaseAssemblyCenter {
    private static let _shared = AssemblyCenter()
    open override class var shared: AssemblyCenter {
        return _shared
    }
    
    //Init
    override init() {
        super.init()
        Container.loggingFunction = nil
    }
    
    public override var assemblies: [Assembly] {
        return [networkAssembly(),
                servicesAssembly()]
    }
}

//MARK: Assemblies
extension AssemblyCenter {
    public func networkAssembly() -> NetworkAssembly {
        return NetworkAssembly()
    }
    
    public func servicesAssembly() -> ServicesAssembly {
        return ServicesAssembly()
    }
}
