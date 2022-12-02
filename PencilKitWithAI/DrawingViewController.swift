//
//  DrawingViewController.swift
//  PencilKitWithAI
//

import Foundation
import UIKit
import SnapKit
import PencilKit

final class DrawingViewController: UIViewController {
    var dataRepository: DataRepository!
    var drawingIndex: Int!
    var drawingImage: UIImage!
    
    private var canvasView: PKCanvasView!
    private var toolPicker: PKToolPicker!
    
    private var actionBarButtonItem: UIBarButtonItem!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // CanvasView
        self.canvasView = PKCanvasView()
        canvasView.drawing = dataRepository.dataModel.drawings[drawingIndex]
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = self
        
        self.view.addSubview(canvasView)
        self.canvasView.snp.makeConstraints { make in
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
        }
        
        // ToolPicker
        self.toolPicker = PKToolPicker()
        self.toolPicker.setVisible(true, forFirstResponder: canvasView)
        self.toolPicker.addObserver(canvasView)
        self.toolPicker.addObserver(self)
        self.updateLayout(for: toolPicker)
        
        // ToolPicker가 보이도록 canvasView를 firstResponsder로 설정
        self.canvasView.becomeFirstResponder()
        
        // ToolbarItems
        self.actionBarButtonItem = UIBarButtonItem(systemItem: .action, primaryAction: UIAction { _ in
            let rect = CGRect(x: 0, y: 0, width: 1024, height: 1024)
            let scale = UIScreen.main.scale
            self.drawingImage = self.canvasView.drawing.image(from: rect, scale: scale)
            
            let activityViewController = UIActivityViewController(activityItems: [self.drawingImage!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.barButtonItem = self.actionBarButtonItem

            self.present(activityViewController, animated: true)
        })
        

        self.navigationItem.rightBarButtonItems = [actionBarButtonItem]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}

private extension DrawingViewController {
    func updateLayout(for toolPicker: PKToolPicker) {
        let obscuredFrame = toolPicker.frameObscured(in: view)
        
        if obscuredFrame.isNull {
            canvasView.contentInset = .zero
        } else {
            canvasView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.bounds.maxY - obscuredFrame.minY, right: 0)
        }
        
        canvasView.scrollIndicatorInsets = canvasView.contentInset
    }
}

// MARK: - PKCanvasViewDelegate
extension DrawingViewController: PKCanvasViewDelegate {
    // Drawing이 추가되었을 경우
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        dataRepository.updateDrawing(canvasView.drawing, at: drawingIndex)
    }
}

// MARK: - PKToolPickerObserver
extension DrawingViewController: PKToolPickerObserver {
    func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
        updateLayout(for: toolPicker)
    }

    func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker) {
        updateLayout(for: toolPicker)
    }
}
