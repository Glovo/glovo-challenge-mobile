//
//  Map.Builder.swift
//  Glovo
//
//  Created by Eugène Peschard on 11/03/2019.
//  Copyright © 2019 pesch.app. All rights reserved.
//

import Foundation
import UIKit

enum Map {
    class Builder {
        
        static func viewController(for window: UIWindow) -> ViewController {
            let viewController = ViewController()
            let interactor = Interactor()
            let presenter = Presenter()
            let router = Router(with: window)
            
            viewController.presenter = presenter
            
            interactor.presenter = presenter
            
            presenter.interactor = interactor
            presenter.view = viewController
            presenter.router = router
            
            router.mapPresenter = presenter
            router.mapViewController = viewController
            
            return viewController
        }
    }
}
