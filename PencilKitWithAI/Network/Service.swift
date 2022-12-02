//
//  Service.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import Foundation
import RxSwift

protocol Service {
    func fetch(endPoint: Requestable) -> Single<Data>
}
