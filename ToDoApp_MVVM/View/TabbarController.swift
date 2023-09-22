//
//  TabbarController.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/22.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let paddingTop: CGFloat = 26.0
        tabBar.frame = .init(
            x: tabBar.frame.origin.x,
            y: tabBar.frame.origin.y - paddingTop,
            width: tabBar.frame.width,
            height: tabBar.frame.height + paddingTop
        )
    }

    private func setUpTabBar() {
        tabBar.tintColor = UIColor.black
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.backgroundColor = UIColor(hexCode: "#FAFAFA")
        let firstViewController = UINavigationController(rootViewController: ProfileViewController())
        firstViewController.tabBarItem.image = UIImage(named: "Profile - Fill")
        viewControllers = [firstViewController]
    }
}
