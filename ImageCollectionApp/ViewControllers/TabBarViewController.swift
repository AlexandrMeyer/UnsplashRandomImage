//
//  TabBarViewController.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
        
        viewControllers = [setupRandomImageCollectionViewController(), setupFavoriteImageListViewController()]
    }
    
    private func setupRandomImageCollectionViewController() -> UINavigationController {
        let randomImageCollectionViewController = RandomImageCollectionViewController()
        let icon = UITabBarItem(title: "Images", image: UIImage(systemName: "photo.on.rectangle.angled"), selectedImage: UIImage(systemName: "photo.on.rectangle.angled"))
        randomImageCollectionViewController.tabBarItem = icon
        
        let imageNavigationController = UINavigationController()
        imageNavigationController.viewControllers = [randomImageCollectionViewController]
        
        return imageNavigationController
    }

    private func setupFavoriteImageListViewController() -> UINavigationController {
        let favoriteImageListViewController = FavoriteImageListViewController()
        let icon = UITabBarItem(title: "Favorite", image: UIImage(systemName: "photo"), selectedImage: UIImage(systemName: "photo"))
        favoriteImageListViewController.tabBarItem = icon
        
        let favoriteNavigationController = UINavigationController()
        favoriteNavigationController.viewControllers = [favoriteImageListViewController]
        
        return favoriteNavigationController
    }
}
