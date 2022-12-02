//
//  ServiceImpl.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import Foundation

final class ServiceImpl {
    private let urlSession = URLSession.shared
}
extension ServiceImpl: Service {
    func fetch(from endPoint: Requestable) async -> Result<Data, NetworkError> {
        return await withCheckedContinuation { continuation in

            guard let urlRequest = endPoint.urlRequest else { return continuation.resume(returning: .failure(.invaildURL)) }

            urlSession.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    return continuation.resume(returning: .failure(.network))
                }

                guard let httpURLResponse = response as? HTTPURLResponse else {
                    return continuation.resume(returning: .failure(.httpResponse))
                }

                if httpURLResponse.statusCode == 400 {
                    return continuation.resume(returning: .failure(.badRequest))
                }

                if httpURLResponse.statusCode == 401 {
                    return continuation.resume(returning: .failure(.unauthorized))
                }

                if httpURLResponse.statusCode == 500 {
                    return continuation.resume(returning: .failure(.internalServerError))
                }

                guard (200...299) ~= httpURLResponse.statusCode else {
                    return continuation.resume(returning: .failure(.responseCode(code: httpURLResponse.statusCode)))
                }

                guard let data = data else {
                    return continuation.resume(returning: .failure(.emptyData))
                }

                continuation.resume(returning: .success(data))
            }.resume()
        }
    }
}
