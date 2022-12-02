//
//  NetworkRepository.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import Foundation
import UIKit.UIImage

final class NetworkRepository: ObservableObject {
    private let service: Service = ServiceImpl()

    func requestImage(_ image: UIImage, _ text: String) async -> Result<Data, NetworkError> {
        let endPoint = EndPoint.imageToImage(image: image.pngData()!, text: text)
        return await service.fetch(from: endPoint)
    }

    func requestImage(_ text: String) async -> Result<Data, NetworkError> {
        let endPoint = EndPoint.textToImage(text: text)
        return await service.fetch(from: endPoint)
    }
}
