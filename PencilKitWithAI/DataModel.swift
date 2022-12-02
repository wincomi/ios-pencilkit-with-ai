//
//  DataModel.swift
//  PencilKitWithAI
//

import PencilKit

struct DataModel: Codable {
    static let canvasWidth: CGFloat = 768
    
    var drawings: [PKDrawing] = []
}
