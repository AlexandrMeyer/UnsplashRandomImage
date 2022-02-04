//
//  RandomImageCollectionViewController.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import UIKit


class RandomImageCollectionViewController: UICollectionViewController {
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private var activityIndicator: UIActivityIndicatorView?
    
    private var viewModel: RandomImageCollectionViewModelProtocol! {
        didSet {
            viewModel.fetchImages {
                self.collectionView.reloadData()
                self.activityIndicator?.stopAnimating()
            }
            title = viewModel.title
        }
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel = RandomImageCollectionViewModel()
        activityIndicator = showActivityIndicator(in: view)
        collectionView.register(ImageCellCollectionView.self, forCellWithReuseIdentifier: ReuseIdentifier.cell.rawValue)
        
        setupSearchController()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}

// MARK: UICollectionViewDataSource
extension RandomImageCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.cell.rawValue, for: indexPath) as! ImageCellCollectionView
        
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        
        return cell
    }
}

// MARK: - Navigation
extension RandomImageCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailImageVC = DetailImageViewController()
        let detailsVM = viewModel.detailsViewModel(at: indexPath)
        detailImageVC.viewModel = detailsVM
        navigationController?.pushViewController(detailImageVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RandomImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: - Search Controller
extension RandomImageCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        viewModel.filterContentForSearchText(searchText) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupSearchController() {
        navigationItem.searchController = SearchController.shared.searchController
        SearchController.shared.searchController.searchResultsUpdater = self
        SearchController.shared.searchController.obscuresBackgroundDuringPresentation = false
        SearchController.shared.searchController.automaticallyShowsSearchResultsController = true
        SearchController.shared.searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
    }
}
