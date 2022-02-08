//
//  DetailSavedImageViewController.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import UIKit

class DetailSavedImageViewController: UIViewController {
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.setTitle("Delete from Favorite", for: .normal)
        button.addTarget(self, action: #selector(deleteFromFavorite), for: .touchUpInside)
        
        return button
    }()
    
    var viewModel: DetailSavedImageViewModelProtocol! {
        didSet {
            viewModel.getImageData { [weak self]  imageData in
                self?.image.image = UIImage(data: imageData)
            }
            descriptionLabel.text = self.viewModel.descriptionLabel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        setupSubviews(image, descriptionLabel, button)
        
        setImageConstraints()
        setLabelConstraints()
        setButtonConstraints()
    }
    
    private func setupSubviews(_ subViews: UIView...) {
        subViews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setImageConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 2)
        ])
    }
    
    private func setLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setButtonConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    @objc func deleteFromFavorite() {
        viewModel.deleteFromFavoriteButtonTapped()
        present(AlertController.shared.showAlert(with: viewModel.authorName, message: "Image was deleted"), animated: true)
    }
}
