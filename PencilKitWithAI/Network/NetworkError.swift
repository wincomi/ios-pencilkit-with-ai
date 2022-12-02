//
//  NetworkError.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import Foundation

enum NetworkError: Error, Comparable {
    case network
    case invaildURL
    case httpResponse
    case failToDecode
    case responseCode(code: Int)
    case emptyData
    case badRequest
    case unauthorized
    case internalServerError
}

