//
//  HomeViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 5/13/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreLocation

protocol HomeDisplayLogic: class {
}

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var mapViewContainer: UIView!
    @IBOutlet private weak var locationAccessView: LocationAccessView!
    
    private var searchAreaButton: UIButton?
    
    public var router: (NSObjectProtocol & HomeRoutingLogic)?
    
    private var currentLocationAuthorizationStatus: CLAuthorizationStatus!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        HomeConfigurator.shared.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        prepareRoute(for: segue, router: router)
    }    
}

// MARK: - Private Methods
extension HomeViewController {
    
    private func setupUI() {
        
        setNavigationShadow()
    }
    
    private func showMapView() {

        mapViewContainer.isHidden = false

        if currentLocationAuthorizationStatus == .denied {
            
            locationAccessView.isHidden = false
        } else {
            
            locationAccessView.isHidden = true
        }
    }
}

// MARK: - Map View Controller Delegate
extension HomeViewController: MapViewControllerDelegate {
    
    func mapViewDidShow(_ mapView: MapViewController) {
     
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)
    }
        
    func mapViewAllowedLocationAccess(_ mapView: MapViewController) {
        
        currentLocationAuthorizationStatus = .authorizedAlways
        locationAccessView.isHidden = true
    }
    
    func mapViewDeniedLocationAccess(_ mapView: MapViewController) {
     
        currentLocationAuthorizationStatus = .denied
        locationAccessView.isHidden = false
    }
}

// MARK: - Home Display Logic
extension HomeViewController: HomeDisplayLogic {    
}

