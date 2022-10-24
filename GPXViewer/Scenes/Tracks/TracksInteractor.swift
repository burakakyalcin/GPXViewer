//
//  TracksInteractor.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 20/10/2022.
//

import Foundation

protocol TracksInteractorDelegate: AnyObject {
    func interactorDidUpdateViewModel(_ viewModel: TracksViewModel)
}

class TracksInteractor {
    typealias Context = TracksRepositoryProvider
    
    weak var delegate: TracksInteractorDelegate?
    private let context: Context
    
    struct State: Equatable {
        var tracks: [Track] = []
    }
    
    private var state: State {
        didSet {
            guard state != oldValue else { return }

            viewModel = TracksViewModelBuilder.build(with: state)
        }
    }

    private(set) var viewModel: TracksViewModel {
        didSet {
            guard viewModel != oldValue else { return }
            delegate?.interactorDidUpdateViewModel(viewModel)
        }
    }
    
    init(context: Context) {
        self.state = State()
        self.context = context
        self.viewModel = TracksViewModelBuilder.build(with: state)
    }
    
    func load() {
        let tracks = context.tracksRepository.getTracks()
        state.tracks = tracks
    }
}
