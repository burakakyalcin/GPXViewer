//
//  TrackDetailViewController.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 21/10/2022.
//

import MapKit

protocol TrackDetailViewControllerDelegate: AnyObject {
    func viewControllerWantsToShowTrackInfo(_ viewController: TrackDetailViewController, track: Track)
}

class TrackDetailViewController: UIViewController {
    weak var delegate: TrackDetailViewControllerDelegate?
    private var interactor: TrackDetailInteractor
    private var isMapCenterUpdated: Bool = false
    
    private lazy var mapView: MKMapView = {
       let mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var showDetailsButton: UIButton = {
        var configuration: UIButton.Configuration = .filled()
        configuration.title = "Show track info"
        configuration.cornerStyle = UIButton.Configuration.CornerStyle.capsule
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentModal), for: .touchUpInside)
        return button
    }()
    
    init(interactor: TrackDetailInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = interactor.track.name
        
        addComponents()
        layoutComponents()
        
        draw(track: interactor.track)
        addStartAndEndPointAnnotations()
        zoomMap(to: interactor.track.trackDetails.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) })
    }
    
    private func addComponents() {
        view.addSubview(mapView)
        view.addSubview(showDetailsButton)
    }
    
    private func layoutComponents() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            showDetailsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            showDetailsButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            showDetailsButton.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            showDetailsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func draw(track: Track) {
        let trackCoordinates = track.trackDetails.compactMap { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude )}
        let polyline = MKPolyline(coordinates: trackCoordinates, count: trackCoordinates.count)
        mapView.addOverlay(polyline)
    }
    
    private func zoomMap(to coordinates: [CLLocationCoordinate2D]) {
        guard let region = MKCoordinateRegion(coordinates: coordinates) else { return }
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    private func addStartAndEndPointAnnotations() {
        guard let firstTrackDetail = interactor.track.trackDetails.first, let lastTrackDetail = interactor.track.trackDetails.last else { return }
        let startCoordinate = CLLocationCoordinate2D(latitude: firstTrackDetail.latitude, longitude: firstTrackDetail.longitude)
        let endCoordinate = CLLocationCoordinate2D(latitude: lastTrackDetail.latitude, longitude: lastTrackDetail.longitude)
        addAnnotation(for: startCoordinate, title: "Start")
        addAnnotation(for: endCoordinate, title: "End")
    }
    
    private func addAnnotation(for coordinate: CLLocationCoordinate2D, title: String) {
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = coordinate
        mapView.addAnnotation(point)
    }
    
    @objc
    private func presentModal() {
        delegate?.viewControllerWantsToShowTrackInfo(self, track: interactor.track)
    }
    
    func updateMapRegion(isSheetVisible: Bool, height: Double) {
        if isSheetVisible {
            alignMapCenterToFit(height: height)
        } else {
            zoomMap(to: interactor.track.trackDetails.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) })
            isMapCenterUpdated = false
        }
    }
    
    private func alignMapCenterToFit(height: Double) {
        if !isMapCenterUpdated {
            let coordinates = interactor.track.trackDetails.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
            guard let region = MKCoordinateRegion(coordinates: coordinates) else { return }
            mapView.setRegion(mapView.regionThatFits(region), animated: false)
            mapView.setVisibleMapRect(mapView.visibleMapRect, edgePadding: UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0), animated: true)
            isMapCenterUpdated = true
        }
    }
}

extension TrackDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = .blue.withAlphaComponent(0.9)
            renderer.lineWidth = 2
            return renderer
        }

        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        mapView.showAnnotations([annotation], animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
        zoomMap(to: interactor.track.trackDetails.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) })
    }
}
