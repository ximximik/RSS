//
//  Created by i20 on 02.02.17.
//  Copyright © 2017 i20. All rights reserved.
//

import RxCocoa
import RxSwift

extension ObservableType where E: Sequence {
    
    /**
     Takes a sequence elements and returns a sequence transofrmed by closure elements.
     
     - returns: An observable sequence transofrmed elements
     */
    public func mapElement<T>(transform: @escaping (E.Iterator.Element) -> T) -> Observable<[T]>  {
        return self
            .map { sequence -> [T] in
                return sequence.map(transform)
        }
    }
}
