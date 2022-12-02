//
//  Service.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import Foundation

protocol Service {
    func fetch(from api: Requestable) async -> Result<Data, NetworkError>
}
