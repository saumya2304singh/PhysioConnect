//
//  MainTabBarController.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.

import UIKit

final class MainTabBarController: UITabBarController {

    private let customHeight: CGFloat = 66
    private let bottomOffset: CGFloat = 24   // how much above bottom
    
    private var blurView: UIVisualEffectView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        setupAppearance()
    }

    // MARK: - Force Frame AFTER Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let horizontalInset: CGFloat = 16      // spacing on left & right
        //let customHeight: CGFloat = 72
        //let bottomOffset: CGFloat = 16

        var tabFrame = tabBar.frame
        tabFrame.size.height = customHeight
        tabFrame.origin.y = view.frame.height - customHeight - bottomOffset
        tabFrame.origin.x = horizontalInset
        tabFrame.size.width = view.frame.width - (horizontalInset * 2)

        tabBar.frame = tabFrame

        tabBar.layer.cornerRadius = 33
        tabBar.layer.masksToBounds = false

        // Update blur view frame to match
        blurView?.frame = tabBar.bounds
    }


    
    // MARK: - Tabs Setup
    private func setupTabs() {

        let homeVC = LandingHomeScreenViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house.fill"),
            tag: 0
        )

        let appVC = AppointmentsTabViewController()
        appVC.view.backgroundColor = .white
        let appNav = UINavigationController(rootViewController: appVC)
        appNav.tabBarItem = UITabBarItem(
            title: "Appointments",
            image: UIImage(systemName: "calendar"),
            tag: 1
        )

        let videoVC = UIViewController()
        videoVC.view.backgroundColor = .white
        let videoNav = UINavigationController(rootViewController: videoVC)
        videoNav.tabBarItem = UITabBarItem(
            title: "Videos",
            image: UIImage(systemName: "play.rectangle.fill"),
            tag: 2
        )

        let articlesVC = UIViewController()
        articlesVC.view.backgroundColor = .white
        let articlesNav = UINavigationController(rootViewController: articlesVC)
        articlesNav.tabBarItem = UITabBarItem(
            title: "Articles",
            image: UIImage(systemName: "doc.text.image"),
            tag: 3
        )

        viewControllers = [homeNav, appNav, videoNav, articlesNav]
    }

    
    // MARK: - Appearance
    private func setupAppearance() {

        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true

        // Glass blur view
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
        blur.frame = tabBar.bounds
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blur.layer.cornerRadius = 33
        blur.clipsToBounds = true

        tabBar.insertSubview(blur, at: 0)
        blurView = blur

        // Shadow (floating effect)
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.15
        tabBar.layer.shadowRadius = 18
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 6)

        // Icon Colors
        UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray.withAlphaComponent(0.8)
        UITabBar.appearance().tintColor = UIColor(hex: "1E6EF7")
    }
}
