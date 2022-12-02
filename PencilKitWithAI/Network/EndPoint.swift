//
//  EndPoint.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import Foundation

enum EndPoint {
    case foo
    case bar
}

extension EndPoint: Requestable {
    var method: HTTPMethod {
        return .post
    }

    var scheme: String {
        return "https"

    }

    var base: String {
        switch self {
        default:
            return ""
        }
    }

    var path: String {
        switch self {
        default:
            return ""
        }
    }

    var queryItem: [String: String] {
        switch self {
        default:
            return [:]
        }
    }

    var headers: [String: String] {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }

    var url: URL? {
        var component = URLComponents(string: base)
        component?.scheme = scheme
        component?.path.append(path)
        component?.queryItems = queryItem.map { URLQueryItem(name: $0.key, value: $0.value) }
        return component?.url
    }

    var urlRequest: URLRequest? {
        guard let url = self.url else { return nil}
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }

}
