//
//  ViewController.swift
//  PencilKitWithAI
//
//  Created by COMI on 2022/12/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxAppState

final class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()

    private var viewModel: MainViewModel?

    private let collectionView: UICollectionView = {
        let section: NSCollectionLayoutSection = .init(itemWidth: .fractionalWidth(0.2),
                                                       itemHeight: .fractionalHeight(1),
                                                       groupWidth: .fractionalWidth(1),
                                                       groupHeight: .fractionalWidth(0.3),
                                                       contentInset: .init(top: 8, leading: 8, bottom: 8, trailing: 8))

        let layout = UICollectionViewCompositionalLayout(section: section)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DrawingCell.self, forCellWithReuseIdentifier: DrawingCell.identifier)
        return collectionView
    }()

    private let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"))

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = plusButton

        layoutCollectionView()
    }

    private func pushDrawingView() {

    }
}

extension MainViewController {
    func configure(with viewModel: MainViewModel) {
        self.viewModel = viewModel

        viewModel.output.loadedThumbnail
            .bind(to: collectionView.rx.items(cellIdentifier: DrawingCell.identifier,
                                              cellType: DrawingCell.self)) { _, image, cell in
                cell.configure(with: image)}
            .disposed(by: disposeBag)

        plusButton.rx.tap
            .bind(to: viewModel.input.plusButtonTapped)
            .disposed(by: disposeBag)
    }
}


private extension MainViewController {
    func layoutCollectionView() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}
