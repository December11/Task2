//
//  TabbarController.swift
//  Task2
//
//  Created by Alla Shkolnik on 28.06.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .systemBlue
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        var houseIcon = UIImage()
        var profileIcon = UIImage()
        if let house = UIImage(systemName: "house") {
            houseIcon = house
        }
        if let person = UIImage(systemName: "person") {
            profileIcon = person
        }
        viewControllers = [
            createViewCotroller(for: LibraryViewController(), title: "Books", image: houseIcon),
            createViewCotroller(for: ColorViewController(), title: "Color", image: houseIcon)
        ]
    }
    
//    private func createTabBarItem(for controller: UIViewController, title: String, image: UIImage) -> UITabBarItem {
//        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
//        self.tabBarItem = tabBarItem
//    }
    private func createViewCotroller(for viewController: UIViewController, title: String, image: UIImage)
    -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.title = title
//        navigationController.navigationBar.prefersLargeTitles = true
//        viewController.navigationController?.title = title // uncomment when add NavBar
        return navigationController
    }
}
