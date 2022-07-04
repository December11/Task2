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
        let libraryNavigationController = configuratedController(from: LibraryViewController(), tab: .library)
        let colorNavigationController = configuratedController(from: ColorViewController(), tab: .color)
        viewControllers = [libraryNavigationController, colorNavigationController]
        selectedViewController = viewControllers?.last
    }
    
    private func setTabBarItem(for viewController: UIViewController, _ tab: Tab) {
        let tabbarItem = UITabBarItem(
            title: tab.title,
            image: UIImage(systemName: tab.iconTitle),
            selectedImage: UIImage(systemName: tab.selectedIconTitle)
        )
        viewController.tabBarItem = tabbarItem
    }
    
    private func configuratedController(from viewController: UIViewController, tab: Tab) -> UINavigationController {
        viewController.title = tab.title
        setTabBarItem(for: viewController, tab)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barTintColor = .white
        
        return navigationController
    }
}
