//
//  DrawingViewController.swift
//  PencilKitWithAI
//

import Foundation
import UIKit
import SnapKit
import PencilKit

final class DrawingViewController: UIViewController {
    var dataModel: DataModel!
    
    private var canvasView: PKCanvasView!
    private var toolPicker: PKToolPicker!
    
    private var actionBarButtonItem: UIBarButtonItem!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // CanvasView
        self.canvasView = PKCanvasView()
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
        let activityViewController = UIActivityViewController(activityItems: [], applicationActivities: nil)
        self.actionBarButtonItem = UIBarButtonItem(systemItem: .action, primaryAction: UIAction { _ in
            self.present(activityViewController, animated: true)
        })
        activityViewController.popoverPresentationController?.barButtonItem = self.actionBarButtonItem

        self.navigationItem.rightBarButtonItems = [actionBarButtonItem]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Drawing 업데이트
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
