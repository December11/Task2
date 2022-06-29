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
        configurateTabBar()
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
    
    private func configurateTabBar() {
        let tabs = [Tab.library, Tab.color]
        tabs.forEach { self.tabBarItem = getTabBarItem(for: $0) }
        let libraryVC = createNavigationController(for: LibraryViewController(), for: Tab.library)
        let colorVC = createNavigationController(for: ColorViewController(), for: Tab.color)
        self.viewControllers = [libraryVC, colorVC]
        self.selectedViewController = colorVC
    }
    
    private func getTabBarItem(for tab: Tab) -> UITabBarItem {
        return UITabBarItem(
            title: tab.title,
            image: UIImage(systemName: tab.iconTitle),
            selectedImage: UIImage(systemName: tab.selectedIconTitle)
        )
    }
    
    private func createNavigationController(for viewController: UIViewController, for tab: Tab)
    -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.title = tab.title
        navigationController.tabBarItem = getTabBarItem(for: tab)
        return navigationController
    }
}
