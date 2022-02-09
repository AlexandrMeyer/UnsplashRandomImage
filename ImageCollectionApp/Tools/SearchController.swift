//
//  SearchController.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import UIKit

class SearchController {
    
    static let shared = SearchController()
    
    private init() {}
    
    let searchController: UISearchController = UISearchController()
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
}
