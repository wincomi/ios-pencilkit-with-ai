//
//  DrawingView.swift
//  PencilKitWithAI
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    @EnvironmentObject var networkRepository: NetworkRepository
    var dataRepository: DataRepository
    var item: DrawingItem
    @State var drawing = PKDrawing()
    @State var aiImage: Image = .init(systemName: "plus")
    
    var body: some View {
        CanvasView(drawing: item.drawing, drawingPolicy: .anyInput, drawingDidChange: drawingDidChange)
            .frame(width: 512, height: 512)
//            .border(Color.black)
            .ignoresSafeArea()
            .toolbar {
                Button {
                    dataRepository.delete(item)
                } label: {
                    Text("삭제")
                        .foregroundColor(.red)
                }
                Button {
                    Task {
                        let foo = await networkRepository.requestImage("")
                        switch foo {
                        case .success(let data):
                            let uiImage = UIImage(data: data)
                            let image = Image(uiImage: uiImage!)
                            self.aiImage = image
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                } label: {
                    Text("AI 이미지 생성")
                }
                Button {
                    dataRepository.update(DrawingItem(id: item.id, name: item.name, drawing: drawing))
                } label: {
                    Text("저장")
                        .bold()
                }
            }
            .navigationTitle(item.name == "" ? "제목 없음" : item.name)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                drawing = item.drawing
            }
    }

    func something() {

    }
    
    func drawingDidChange(canvasView: PKCanvasView) {
        drawing = canvasView.drawing
//        dataRepository.update(item)
    }
}
