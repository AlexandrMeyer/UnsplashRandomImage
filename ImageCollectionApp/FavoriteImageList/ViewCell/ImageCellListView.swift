//
//  ImageCellListView.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import UIKit

class ImageCellListView: UITableViewCell {
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 4
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.tintColor = .black
        return label
    }()
    
    var viewModel: ImageCellListViewModelProtocol! {
        didSet {
            viewModel.getImageData { [weak self] imageData in
                self?.image.image = UIImage(data: imageData)
            }
            nameLabel.text = self.viewModel.label
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews(image, nameLabel)
        setImageConstraint()
        setLabelConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    private func setImageConstraint() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 158),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setLabelConstraint() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
    }
}
