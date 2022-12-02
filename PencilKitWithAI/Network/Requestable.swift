//
//  Requestable.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import Foundation

protocol Requestable {
    var method: HTTPMethod { get }
    var scheme: String { get }
    var base: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var queryItem: [String: String] { get }
    var url: URL? { get }
    var urlRequest: URLRequest? { get }
}

enum HTTPMethod: String {
    case post = "POST"
}
