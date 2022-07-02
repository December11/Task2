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
        tabBar.tintColor = .systemTeal
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
        self.viewControllers = [libraryViewController, colorViewController]
        self.selectedViewController = colorViewController
        
        let libraryTabItem = tabBarItem(Tab.library)
        libraryViewController.tabBarItem = libraryTabItem
        
        let colorTabItem = tabBarItem(Tab.color)
        colorViewController.tabBarItem = colorTabItem
    }
    
    private func tabBarItem(_ tab: Tab) -> UITabBarItem {
        return UITabBarItem(
            title: tab.title,
            image: UIImage(systemName: tab.iconTitle),
            selectedImage: UIImage(systemName: tab.selectedIconTitle)
        )
    }
}
