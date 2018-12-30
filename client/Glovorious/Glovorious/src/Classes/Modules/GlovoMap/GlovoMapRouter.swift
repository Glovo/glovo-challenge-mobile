//
//  GlovoMapRouter.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 22/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import UIKit

class GlovoMapRouter: IGlovoMapRouter {
   
    weak var glovoView: GlovoMapViewController!
    
    func generateModule() -> UIViewController {
        let dataManager = GlovoDataManager(userDefaults: UserDefaults.standard)
        let service = GlovoService()
        let interactor = GlovoMapInteractor()
        let presenter = GlovoMapPresenter(interactor: interactor)
        let locationManager = GlovoLocationManager()
        interactor.dataManager = dataManager
        interactor.service = service
        interactor.delegate = presenter
        let view = GlovoMapViewController()
        view.locationManager = locationManager
        locationManager.register(delegate: view)
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = self
        self.glovoView = view
        return view
    }
    
    func showCountryDialog() -> UIView {
        if let window = UIApplication.shared.keyWindow {
            let dialog = PopupDialogView(with: window.bounds, title: "Choose Country", isCountry: true)
            dialog.delegate = glovoView
            return dialog
        }
        return UIView()
    }
    
    func showCityDialog() -> UIView {
        if let window = UIApplication.shared.keyWindow {
            let dialog = PopupDialogView(with: window.bounds, title: "Choose City", isCountry: false)
            dialog.delegate = glovoView
            return dialog
        }
        return UIView()
    }
}

