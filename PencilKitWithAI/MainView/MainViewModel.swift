//
//  MainViewModel.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/02.
//

import Foundation
import UIKit.UIImage
import RxRelay
import RxSwift
import RxCocoa

final class MainViewModel {
    struct Input {
        let viewDidLoad = PublishRelay<Void>()
    }

    struct Output {
        let loadedThumbnail = PublishRelay<[UIImage]>()
    }

    let input = Input()
    let output = Output()

    init () {
        
    }
}
