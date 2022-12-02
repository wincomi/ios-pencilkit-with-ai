//
//  SceneDelegate.swift
//  PencilKitWithAI
//
//  Created by COMI on 2022/12/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let viewController = DrawingViewController()
        let dataRepository = DataRepository()
        viewController.dataRepository = dataRepository
        viewController.drawingIndex = 0
        
        let navigationController = UINavigationController(rootViewController: viewController)
                
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

