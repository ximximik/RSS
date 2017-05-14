//
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation
import Swinject

public class ServicesAssembly: BaseAssembly {
    
    public func assemble(container: Container) {
        //AppearanceAdjuster
        container.register(AppearanceAdjuster.self) { _ in
            AppearanceAdjusterDefault()
            }
            .inObjectScope(.container)
    }
    
    public func appearanceAdjuster() -> AppearanceAdjuster {
        return container.resolve(AppearanceAdjuster.self)!
    }
}
