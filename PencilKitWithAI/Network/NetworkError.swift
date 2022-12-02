//
//  NetworkError.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case failToDecode
    case emptyData
    case response(code: Int)
}

