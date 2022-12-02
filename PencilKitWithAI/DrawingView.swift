//
//  DrawingView.swift
//  PencilKitWithAI
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    @EnvironmentObject var dataRepository: DataRepository
    var item: DrawingItem
    
    var body: some View {
        CanvasView(drawing: item.drawing, drawingPolicy: .anyInput, drawingDidChange: drawingDidChange)
            .ignoresSafeArea()
    }
    
    func drawingDidChange(canvasView: PKCanvasView) {
        dataRepository.update(item)
    }
}
