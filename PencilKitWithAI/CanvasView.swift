//
//  CanvasView.swift
//  PencilKitWithAI
//

import UIKit
import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    class Coordinator: NSObject, PKCanvasViewDelegate, PKToolPickerObserver {
        var drawingDidChange: ((PKCanvasView) -> Void)? = nil
        var didEndUsingTool: ((PKCanvasView) -> Void)? = nil
        var didFinishRendering: ((PKCanvasView) -> Void)? = nil
        var didBeginUsingTool: ((PKCanvasView) -> Void)? = nil

        // MARK: - PKCanvasViewDelegate
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            drawingDidChange?(canvasView)
        }
        
        func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
            didEndUsingTool?(canvasView)
        }
        
        func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
            didFinishRendering?(canvasView)
        }
        
        func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
            didBeginUsingTool?(canvasView)
        }
        
        // MARK: - PKToolPickerObserver
        func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker) {
            // TODO: -
        }
        
        func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
            // TODO: -
        }
    }

    var drawing: PKDrawing = PKDrawing()
    var drawingPolicy: PKCanvasViewDrawingPolicy
    var drawingDidChange: ((PKCanvasView) -> Void)? = nil
    var didEndUsingTool: ((PKCanvasView) -> Void)? = nil
    var didFinishRendering: ((PKCanvasView) -> Void)? = nil
    var didBeginUsingTool: ((PKCanvasView) -> Void)? = nil
    
    private let canvasView = PKCanvasView()
    private let toolPicker = PKToolPicker()

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.delegate = context.coordinator
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        toolPicker.addObserver(context.coordinator)
        
        canvasView.contentInset = .zero
        canvasView.scrollIndicatorInsets = canvasView.contentInset

        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.drawing = drawing
        uiView.drawingPolicy = drawingPolicy
        
        DispatchQueue.main.async {
            canvasView.becomeFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator()
        coordinator.drawingDidChange = drawingDidChange
        coordinator.didEndUsingTool = didEndUsingTool
        coordinator.didFinishRendering = didFinishRendering
        coordinator.didBeginUsingTool = didBeginUsingTool
        
        return coordinator
    }
}
