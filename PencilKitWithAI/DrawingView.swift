//
//  DrawingView.swift
//  PencilKitWithAI
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    var dataRepository: DataRepository
    var item: DrawingItem
    @State var drawing = PKDrawing()
    
    var body: some View {
        CanvasView(drawing: item.drawing, drawingPolicy: .anyInput, drawingDidChange: drawingDidChange)
            .ignoresSafeArea()
            .toolbar {
                Button {
                    dataRepository.update(DrawingItem(id: item.id, name: item.name, drawing: drawing))
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
            .onAppear {
                drawing = item.drawing
            }
    }
    
    func drawingDidChange(canvasView: PKCanvasView) {
        drawing = canvasView.drawing
//        dataRepository.update(item)
    }
}
