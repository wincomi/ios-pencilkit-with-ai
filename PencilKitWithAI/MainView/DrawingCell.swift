//
//  DrawingCell.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/02.
//

import UIKit
import SnapKit

final class DrawingCell: UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layoutImageView()
    }
}

extension DrawingCell {
    func configure(with image: UIImage) {
        imageView.image = image
    }
}

private extension DrawingCell {
    func layoutImageView() {
        contentView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}
