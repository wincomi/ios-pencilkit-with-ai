//
//  DrawingView.swift
//  PencilKitWithAI
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    var body: some View {
        CanvasView(drawingPolicy: .anyInput, drawingDidChange: drawingDidChange)
            .ignoresSafeArea()
    }
    
    func drawingDidChange(canvasView: PKCanvasView) {
        
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
