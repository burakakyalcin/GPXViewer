//
//  SceneDelegate.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 19/10/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var tracksCoordinator: TracksCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene

        let appContext = AppInitializer.createAppContext()

        tracksCoordinator = TracksCoordinator(window: appWindow, appContext: appContext)
        tracksCoordinator.start()
    }
}
