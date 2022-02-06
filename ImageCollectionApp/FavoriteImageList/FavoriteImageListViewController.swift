//
//  FavoriteImageListViewController.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import UIKit

class FavoriteImageListViewController: UITableViewController {
    
    private var viewModel: FavoriteImageListViewModelProtocol! {
        didSet {
            viewModel.fetchImage { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ImageCellListView.self, forCellReuseIdentifier: ReuseIdentifier.cell.rawValue)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = FavoriteImageListViewModel()
        tableView.reloadData()
    }
}

// MARK: - Table view data source
extension FavoriteImageListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.cell.rawValue, for: indexPath) as! ImageCellListView
        
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoriteImageListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(150)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            viewModel.deleteImage(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailSavedImageViewController()
        detailVC.viewModel = viewModel.detailsViewModel(at: indexPath)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
