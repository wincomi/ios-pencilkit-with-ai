//
//  DrawingView.swift
//  PencilKitWithAI
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    var dataRepository: DataRepository
    @State var item: DrawingItem
    
    var body: some View {
        CanvasView(drawing: item.drawing, drawingPolicy: .anyInput, drawingDidChange: drawingDidChange)
            .ignoresSafeArea()
            .toolbar {
                Button {
                    dataRepository.update(item)
                } label: {
                    Text("저장")
                }
                Button {
                    dataRepository.delete(item)
                } label: {
                    Text("삭제")
                }
            }
            .navigationTitle(item.name == "" ? "제목 없음" : item.name)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    func drawingDidChange(canvasView: PKCanvasView) {
        self.item.drawing = canvasView.drawing
//        dataRepository.update(item)
    }
}
