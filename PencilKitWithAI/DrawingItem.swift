//
//  DrawingItem.swift
//  PencilKitWithAI
//

import PencilKit
import UIKit.UIImage

struct DrawingItem: Codable, Identifiable {
    var id = UUID()
    var name: String
    var drawing: PKDrawing
}

extension DrawingItem: Equatable {
    static func == (lhs: DrawingItem, rhs: DrawingItem) -> Bool {
        lhs.id == rhs.id
    }
}

extension DrawingItem {
    func image() -> UIImage {
        let thumbnailRect = CGRect(x: 0, y: 0, width: 512, height: 512)
        let thumbnailScale = UIScreen.main.scale

        return drawing.image(from: thumbnailRect, scale: thumbnailScale)
    }
}
