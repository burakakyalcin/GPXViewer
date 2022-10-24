//
//  TracksCoordinator.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 21/10/2022.
//

import UIKit

final class TracksCoordinator: NSObject {
    private let window: UIWindow
    private let interactor: TracksInteractor
    private let appContext: AppContext
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: tracksViewController)
        navigationController.view.backgroundColor = .white
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }()

    private lazy var tracksViewController: TracksViewController = {
        let viewController = TracksViewController(interactor: interactor)
        viewController.title = "Tracks"
        viewController.delegate = self
        return viewController
    }()

    init(window: UIWindow, appContext: AppContext) {
        self.window = window
        self.appContext = appContext
        self.interactor = TracksInteractor(context: appContext)
        super.init()
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func startTrackDetailFlow(with track: Track) {
        let interactor = TrackDetailInteractor(track: track, context: appContext)
        let viewController = TrackDetailViewController(interactor: interactor)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentTrackDetailInfo(with track: Track, presentingViewController: TrackDetailViewController) {
        let interactor = TrackInfoInteractor(track: track)
        let infoViewController = TrackInfoViewController(interactor: interactor)
        infoViewController.onDisplayBlock = { value, height in
            presentingViewController.updateMapRegion(isSheetVisible: value, height: height)
        }
        
        infoViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = infoViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        navigationController.present(infoViewController, animated: true)
    }
}

extension TracksCoordinator: TracksViewControllerDelegate {
    func viewControllerWantsToShowTrackDetail(_ viewController: TracksViewController, track: Track) {
        startTrackDetailFlow(with: track)
    }
}

extension TracksCoordinator: TrackDetailViewControllerDelegate {
    func viewControllerWantsToShowTrackInfo(_ viewController: TrackDetailViewController, track: Track) {
        presentTrackDetailInfo(with: track, presentingViewController: viewController)
    }
}
