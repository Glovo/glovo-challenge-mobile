//
//  GlovoMapViewController.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 22/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Polyline

class GlovoMapViewController : UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var viewInfo: UIView!
    
    var presenter: IGlovoMapPresenter!
    var locationManager: IGlovoLocationManager!
    let radiusRegion: CLLocationDistance = 1000
    let geocoder = CLGeocoder()
    var decodeCoordinates: [CLLocationCoordinate2D]?
    var currentLocationPin = MKPointAnnotation()
    
    init() {
        super.init(nibName: "GlovoMapView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var popupDialogView: UIView = {
        let popupDialog = PopupDialogView(frame: .zero)
        return popupDialog
    }()
    
    override func viewDidLoad() {
        doLoading(true)
        mapView.delegate = self
        mapView.register(GlovoMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    func doLoading(_ load: Bool) {
        DispatchQueue.main.async {
            self.mapView.isUserInteractionEnabled = !load
            self.loadingView.isHidden = !load
            self.loadingView.load(load)
        }
    }
    
    private func moveMapLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: radiusRegion,
                                                  longitudinalMeters: radiusRegion)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func checkServiceArea(completion: @escaping (Bool) -> ())  {
        guard let myLocation = presenter.currentLocation else {
            completion(false)
            return
        }
        let location = CLLocation.init(latitude: myLocation.latitude, longitude: myLocation.longitude)
        geocoder.reverseGeocodeLocation(location) { (loc, error) in
            if let countryCode = self.processGeocode(placeMarks: loc, error: error) {
                completion(self.authorizationStatus() || self.presenter.checkServiceArea(countryCode))
            }
        }
    }
    
    private func processGeocode(placeMarks: [CLPlacemark]?, error: Error?) -> String? {
        guard let places = placeMarks, let place = places.first, let countryCode = place.isoCountryCode else {
            return nil
        }
        return (countryCode)
    }
    
    private func authorizationStatus() -> Bool {
        let authorizationStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        return authorizationStatus == CLAuthorizationStatus.denied
    }
    
    @IBAction func currentLocationButtonAction(_ sender: UIButton) {
        guard let location = presenter.currentLocation else {
            return
        }
        self.moveMapLocation(location: location)
        viewInfo.isHidden = true
    }
    
    @IBAction func settingButtonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Setting", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Choose Country", style: .default, handler: { _ in
            self.showCountryDialog()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {(_: UIAlertAction!) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension GlovoMapViewController: IGlovoMapView {
    func gecode(withCountry country: [Country]) {
        doLoading(false)
        
        checkServiceArea { (result) in
            if !result {
                self.showCountryDialog()
            }
            self.presenter.getAllCities()
        }
    }
    
    func showError(error: NSError) {
        DispatchQueue.main.async {
            self.popupDialogView.removeFromSuperview()
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
                self.doLoading(false)
            }))
            
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
                self.presenter.getAllCountry()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
      
    }
    
    func showCountryDialog() {
        doLoading(false)
        let popupDialogView = self.presenter.getCountryDialog()
        self.popupDialogView = popupDialogView
        self.view.addSubview(self.popupDialogView)
    }
    
    func showCityDialog() {
        DispatchQueue.main.async {
            self.doLoading(false)
            let popupDialogView = self.presenter.getCityDialog()
            self.popupDialogView.removeFromSuperview()
            self.popupDialogView = popupDialogView
            self.view.addSubview(self.popupDialogView)
        }
    }
    
    func getAllWorkingArea() {
        guard let cities = presenter.cities else {
            return
        }
        DispatchQueue.main.async {
            for city in cities {
                self.presenter.getCityDetail(cityCode: city.code)
            }
        }
        
    }
    func showWorkingArea(city: City) {
        let filterWorkingArea = city.workingArea.filter{!$0.isEmpty}
        
        for work in filterWorkingArea {
            self.decodeCoordinates = decodePolyline(work)
        }
        
        DispatchQueue.main.async {
            if let decodeLocation = self.decodeCoordinates, let polygon = self.showPolygon(coordinates: decodeLocation) {
                let locationAnnotation = polygon.coordinate
                let annotation = GlovoAnnotation.init(coordinate: locationAnnotation, city: city)
                
                self.mapView.addAnnotation(annotation)
                self.mapView.addOverlay(polygon)
                if let selectedCity = self.presenter.selectedCity, selectedCity.name == city.name {
                    self.checkServiceArea(completion: { (result) in
                        if !result {
                            self.popupDialogView.removeFromSuperview()
                            self.moveMapLocation(location: locationAnnotation)
                        }
                    })
                } 
            }
        }
    }
    
    func showPolygon(coordinates: [CLLocationCoordinate2D]?) -> MKPolygon? {
        guard let locCoordinate = coordinates else {
            return nil
        }
        
        var locationCoordinates: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        
        for coord in locCoordinate {
            let coordinate = CLLocationCoordinate2D.init(latitude: coord.latitude, longitude: coord.longitude)
            print("coordinate: \(coordinate)")
            locationCoordinates.append(coordinate)
        }
    
        return MKPolygon(coordinates:locationCoordinates, count: locationCoordinates.count)
  
    }
}

extension GlovoMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.locationManager.stopUpdatingLocation()
        presenter.saveLocation(location)
        presenter.getAllCountry()
        self.moveMapLocation(location: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            presenter.getAllCountry()
        }
    }
}

extension GlovoMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view =  MKAnnotationView()
        if var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? GlovoMarkerView {
            pinView = GlovoMarkerView.init(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            pinView.annotation = annotation
            pinView.isDraggable = true
            view = pinView
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            renderer.strokeColor = UIColor.gray
            renderer.lineWidth = 3
            renderer.fillColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
            return renderer
        }
        
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.moveMapLocation(location: view.annotation?.coordinate ?? CLLocationCoordinate2D())
        DispatchQueue.main.async {
            if let annotation = view.annotation as? GlovoAnnotation {
                self.viewInfo.isHidden = false
                self.labelInfo.text = "\(annotation.name)\n\(annotation.countryCode)\n\(annotation.timeZone)\n\(annotation.cityCode)\n\(annotation.currency)"
            }
        }
    }
}


extension GlovoMapViewController: PopupDialogViewDelegate {
    
    
    func popupDialogViewDelegateSetCountryDataSource() -> [Country] {
        if let countries = presenter.countries {
            return countries
        }
        return []
    }
    
    func popupDialogViewDelegateDidSelectCountryCell(object: Country) {
        presenter.getCity(countryCode: object.code)
    }
    
    func popupDialogViewDelegateSetCityDataSource() -> [City] {
        if let cities = presenter.cities {
            return cities
        }
        return []
    }
    
    func popupDialogViewDelegateDidSelectCityCell(object: City) {
        presenter.selectedCity = object
        presenter.getCityDetail(cityCode: object.code)
    }
}
