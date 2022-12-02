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
        let plusButtonTapped = PublishRelay<Void>()
    }

    struct Output {
        let loadedThumbnail = BehaviorRelay<[UIImage]>(value: [])
    }

    private let disposeBag = DisposeBag()

    let input = Input()
    let output = Output()

    init () {
        input.plusButtonTapped
            .map { [UIImage()] }
            .scan([UIImage](), accumulator: +)
            .bind(to: output.loadedThumbnail)
            .disposed(by: disposeBag)
        
    }
}
