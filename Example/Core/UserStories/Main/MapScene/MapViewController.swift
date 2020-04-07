//
//  MapViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapDisplayLogic: class {
    
    func displayAllowedLocationAccess(viewModel: Map.SetupLocationService.ViewModel)
    func displayDeniedLocationAccess(viewModel: Map.SetupLocationService.ViewModel)
    func displayLocationError(viewModel: Map.UpdatingLocation.ViewModel)
    func displayCurrentLocation(viewModel: Map.ShowCurrentLocation.ViewModel)
}

@objc protocol MapViewControllerDelegate: AnyObject {
    
    func mapViewDidShow(_ mapView: MapViewController)
    func mapViewAllowedLocationAccess(_ mapView: MapViewController)
    func mapViewDeniedLocationAccess(_ mapView: MapViewController)
}

class MapViewController: UIViewController {
    
    public var interactor: MapBusinessLogic?
    
    public var delegate: MapViewControllerDelegate?
    
    private var userLocationCamera: GMSCameraPosition?
    private var mapView: GMSMapView!
    private var currentLocationButton: UIButton!
    
    private var displayedLocation: Map.UpdatingLocation.ViewModel.DisplayedLocation! {
        
        willSet(newDisplayedLocation) {
            
            // Setting the camera position with current user location
            if displayedLocation == nil, let newDisplayedLocationLatitude = newDisplayedLocation?.latitude, let newDisplayedLocationLongitude = newDisplayedLocation?.longitude {
                
                let camera = GMSCameraPosition.camera(withLatitude: newDisplayedLocationLatitude, longitude: newDisplayedLocationLongitude, zoom: 15.0)
                mapView.camera = camera
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        let camera = GMSCameraPosition.camera(withLatitude: DeafultGooglePlacesSettings.Coordinates.latitude, longitude: DeafultGooglePlacesSettings.Coordinates.longitude, zoom: DeafultGooglePlacesSettings.Camera.zoom)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.settings.indoorPicker = false
        mapView.setMinZoom(1, maxZoom: 150)
        
        if let path = R.file.googleMapStyleJson.path() {
            
            do {
                
                let mapStyle = try String(contentsOfFile: path)
                mapView.mapStyle = try GMSMapStyle(jsonString: mapStyle)
            } catch {
                // handle error
            }
        }
        
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapConfigurator.shared.configure(self)
        
        setupUI()
        setupLocationService()
    }
}

// MARK: - Private Methods
extension MapViewController {
    
    private func setupUI() {
        
        setupCurrentLocationButton()
    }
    
    private func setupCurrentLocationButton() {
        
        currentLocationButton = UIButton(type: .system)
        currentLocationButton.isHidden = true
        currentLocationButton.backgroundColor = .white
        currentLocationButton.tintColor = R.color.apple()
        currentLocationButton.setImage(R.image.currentLocation(), for: .normal)
        currentLocationButton.frame = CGRect(x: 0, y: 0, width: 39, height: 39)
        currentLocationButton.setRounded()
        currentLocationButton.addShadow(location: .bottom)
        currentLocationButton.addTarget(self, action: #selector(didTapCurrentLocationButton), for: .touchUpInside)
        
        view.addSubview(currentLocationButton)
        
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingConstraint = NSLayoutConstraint(item: currentLocationButton as Any, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -8)
        let bottomConstraint = NSLayoutConstraint(item: currentLocationButton as Any, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -8)
        let widthConstraint = NSLayoutConstraint(item: currentLocationButton as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 39)
        let heightConstraint = NSLayoutConstraint(item: currentLocationButton as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 39)

        view.addConstraints([trailingConstraint, bottomConstraint, widthConstraint, heightConstraint])
    }
    
    // MARK: - Location Method
    private func setupLocationService() {

        let request = Map.SetupLocationService.Request()
        interactor?.setupLocationService(request: request)
    }
}

// MARK: - Action
extension MapViewController {
    
    @objc func didTapCurrentLocationButton() {
        
        let request = Map.ShowCurrentLocation.Request()
        interactor?.showCurrentLocation(request: request)
    }
}

// MARK: - Map Display Logic
extension MapViewController: MapDisplayLogic {

    func displayAllowedLocationAccess(viewModel: Map.SetupLocationService.ViewModel) {
        
        currentLocationButton.isHidden = false
        mapView.isMyLocationEnabled = true
                                
        delegate?.mapViewAllowedLocationAccess(self)
    }
    
    func displayDeniedLocationAccess(viewModel: Map.SetupLocationService.ViewModel) {

        currentLocationButton.isHidden = true
        mapView.isMyLocationEnabled = false
                
        delegate?.mapViewDeniedLocationAccess(self)
    }
    
    func displayLocationError(viewModel: Map.UpdatingLocation.ViewModel) {
        
        print("viewModel \(String(describing: viewModel.error?.message))")
    }

    func displayCurrentLocation(viewModel: Map.ShowCurrentLocation.ViewModel) {
        
        // TODO:
        guard displayedLocation != nil, displayedLocation.latitude != nil, displayedLocation.longitude != nil else {
            
            showWarningAlert(message: R.string.localizable.locationNotDefined())
            return
        }
        
        if let latitude = displayedLocation.latitude, let longitude = displayedLocation.longitude {
            
            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
            userLocationCamera = camera
            mapView.animate(to: camera)
        }
    }
}
