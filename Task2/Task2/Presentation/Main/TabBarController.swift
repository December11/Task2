//
//  TabbarController.swift
//  Task2
//
//  Created by Alla Shkolnik on 28.06.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private enum TabStyle {
        case first
        case second
        
        var title: String {
            switch self {
            case .first:
                return "Таблицы"
                
            case .second:
                return "Цвета"
            }
        }
        
        var iconTitle: String {
            switch self {
            case .first:
                return "books.vertical"
                
            case .second:
                return "paintbrush"
            }
        }
        
        var selectedIconTitle: String {
            switch self {
            case .first:
                return "books.vertical.fill"
                
            case .second:
                return "paintbrush.fill"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .systemBlue
        
        configure()
    }
    
    private func configure() {
        let libraryNavigationController = makeNavigationController(from: LibraryListViewController(), tab: .first)
        let colorNavigationController = makeNavigationController(from: ColorViewController(), tab: .second)
        viewControllers = [libraryNavigationController, colorNavigationController]
        selectedViewController = viewControllers?.last
    }
    
    private func makeNavigationController(from viewController: UIViewController, tab: TabStyle)
    -> UINavigationController {
        configureTabBarItem(for: viewController, with: tab)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barTintColor = .white
        
        return navigationController
    }
    
    private func configureTabBarItem(for viewController: UIViewController, with style: TabStyle) {
        let tabbarItem = UITabBarItem(
            title: style.title,
            image: UIImage(systemName: style.iconTitle),
            selectedImage: UIImage(systemName: style.selectedIconTitle)
        )
        viewController.tabBarItem = tabbarItem
        viewController.title = style.title
    }
    
}
