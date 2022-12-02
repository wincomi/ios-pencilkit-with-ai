//
//  EndPoint.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import Foundation

enum EndPoint {
    case textToImage(text: String)
    case imageToImage(image: Data, text: String)
}

extension EndPoint: Requestable {
    var method: HTTPMethod {
        return .post
    }

    var scheme: String {
        return "http"

    }

    var base: String {
        switch self {
        default:
            return "144.24.109.33:5000"
        }
    }

    var path: String {
        switch self {
        case .imageToImage:
            return "/img2img"
        case .textToImage:
            return "/txt2img"
        }
    }

    var queryItem: [String: String] {
        switch self {
        case .textToImage(let text), .imageToImage(_, let text):
            return ["prompt": text]
        }
    }

    var headers: [String: String] {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }

    var body: Data? {
        switch self {
        case .imageToImage(let image, _):
            return image
        default:
            return nil
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
        request.httpBody = body
        request.httpMethod = method.rawValue
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        print(request)
        return request
    }

}
