//
//  Map.ViewController.swift
//  Glovo
//
//  Created by Eugène Peschard on 11/03/2019.
//  Copyright © 2019 pesch.app. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapViewController: class {
    var presenter: MapPresenter? { get set }
    var mapView: GMSMapView! { get set }
    
    func animateMap(to coordinate: CLLocationCoordinate2D, zoom level: Float)
    func addMapMarker(with title: String, and snippet: String, at center: CLLocationCoordinate2D?)
    func show(_ city: City)
}

extension Map {
    class ViewController: UIViewController, MapViewController {
        
        var presenter: MapPresenter?
        var mapView: GMSMapView!
        
        //MARK: - Initializers
        
        init() {
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: - Run Loop
        
        override func loadView() {
            super.loadView()
            setupMapView()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            presenter?.checkLocationServices()
        }
        
        //MARK: - Private - loadView
        
        private func setupMapView() {
            mapView = GMSMapView(frame: .zero)
            mapView.delegate = self
            mapView.isMyLocationEnabled = true
            view = mapView
        }
        
        //MARK: - MapViewController
        
        func animateMap(to coordinate: CLLocationCoordinate2D, zoom level: Float) {
            //TODO: Pending implementation
        }
        
        func addMapMarker(with title: String, and snippet: String, at center: CLLocationCoordinate2D?) {
            //TODO: Pending implementation
        }
        
        func show(_ city: City) {
            //TODO: Pending implementation
        }
    }
}

//MARK: - GMSMapViewDelegate

extension Map.ViewController: GMSMapViewDelegate {
    
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        //TODO: Pending implementation
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        //TODO: Pending implementation
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //TODO: Pending implementation
        return true
    }
    
}
