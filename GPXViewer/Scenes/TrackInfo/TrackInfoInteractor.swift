//
//  TrackInfoInteractor.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 23/10/2022.
//

import Foundation

protocol TrackInfoInteractorDelegate: AnyObject {
    func interactorDidUpdateViewModel(_ viewModel: TrackInfoViewModel)
}

class TrackInfoInteractor {
    weak var delegate: TrackInfoInteractorDelegate?
    
    private(set) var viewModel: TrackInfoViewModel {
        didSet {
            guard viewModel != oldValue else { return }
            delegate?.interactorDidUpdateViewModel(viewModel)
        }
    }

    init(track: Track) {
        self.viewModel = TrackInfoViewModelBuilder.build(with: track)
    }
}
