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

extension DrawingItem {
    func image(width: Int = 1024, height: Int = 1024) -> UIImage {
        drawing.image(from: CGRect(x: 0, y: 0, width: width, height: height), scale: UIScreen.main.scale)
    }
}
