//
//  Map.Interactor.swift
//  Glovo
//
//  Created by Eugène Peschard on 11/03/2019.
//  Copyright © 2019 pesch.app. All rights reserved.
//

import Foundation
import RealmSwift
import GoogleMaps

protocol MapInteractor {
    var presenter: MapPresenter? { get set }
}

extension Map {
    class Interactor: MapInteractor {
        weak var presenter: MapPresenter?        
    }
}
