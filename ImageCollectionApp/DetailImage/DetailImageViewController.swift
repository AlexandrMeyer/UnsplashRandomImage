//
//  DetailImageViewController.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import UIKit

class DetailImageViewController: UIViewController {
    
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
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    var viewModel: DetailImageViewModelProtocol! {
        didSet {
            descriptionLabel.text = viewModel.descriptionLabel
            viewModel.getImageData { [weak self] imageData in
                self?.image.image = UIImage(data: imageData)
            }
        }
    }
    
    var savedImageViewModel: DetailSavedImageViewModelProtocol! {
        didSet {
            descriptionLabel.text = savedImageViewModel.descriptionLabel
            viewModel.getImageData { [weak self] imageData in
                self?.image.image = UIImage(data: imageData)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to Favorite", style: .plain, target: self, action: #selector(addToFavorite))
        setupSubviews(image, descriptionLabel)
        
        setImageConstraints()
        setLabelConstraints()
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
    
    @objc func addToFavorite() {
        viewModel.addToFavoriteButtonTapped()
        present(AlertController.shared.showAlert(with: viewModel.authorName, message: "Image add to Favorite"), animated: true)
    }
    
    @objc func deleteFromFavorite() {
        savedImageViewModel.deleteFromFavoriteButtonTapped()
        present(AlertController.shared.showAlert(with: savedImageViewModel.authorName, message: "Image was deleted"), animated: true)
    }
}
