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
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .systemBlue
        configurate()
    }
    
    private enum Tab {
        case library
        case color
        
        var title: String {
            switch self {
            case .library:
                return "Library"
            case .color:
                return "Color"
            }
        }
        
        var iconTitle: String {
            switch self {
            case .library:
                return "books.vertical"
            case .color:
                return "paintbrush"
            }
        }
        
        var selectedIconTitle: String {
            switch self {
            case .library:
                return "books.vertical.fill"
            case .color:
                return "paintbrush.fill"
            }
        }
    }
    
    private func configurate() {
        let libraryViewController = LibraryViewController()
        let colorViewController = ColorViewController()
        
//        let libraryNavigationController = UINavigationController(rootViewController: libraryViewController)
//        let colorNavigationController = UINavigationController(rootViewController: colorViewController)
        
        self.viewControllers = [libraryViewController, colorViewController]
        self.selectedViewController = viewControllers?.last
        
        setTabBarItem(of: libraryViewController, Tab.library)
        setTabBarItem(of: colorViewController, Tab.color)
    }
    
    private func navigationController(viewController: UIViewController, tab: Tab) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.title = tab.title
//        setTabBarItem(of: viewController, tab)
        return navigationController
    }
    
    private func setTabBarItem(of viewController: UIViewController, _ tab: Tab) {
        let tabbarItem = UITabBarItem(
            title: tab.title,
            image: UIImage(systemName: tab.iconTitle),
            selectedImage: UIImage(systemName: tab.selectedIconTitle)
        )
        viewController.tabBarItem = tabbarItem
    }
}
