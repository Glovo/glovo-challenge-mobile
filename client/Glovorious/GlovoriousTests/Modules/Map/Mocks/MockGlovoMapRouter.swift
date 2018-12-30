//
//  MockGlovoMapRouter.swift
//  GlovoriousTests
//
//  Created by Octo Siswardhono on 30/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import UIKit

@testable import Glovorious

class MockGlovoMapRouter: IGlovoMapRouter {
    var invokedGenerateModule = false
    var invokedGenerateModuleCount = 0
    var stubbedGenerateModuleResult: UIViewController!
    func generateModule() -> UIViewController {
        invokedGenerateModule = true
        invokedGenerateModuleCount += 1
        return stubbedGenerateModuleResult
    }
    var invokedShowCountryDialog = false
    var invokedShowCountryDialogCount = 0
    var stubbedShowCountryDialogResult: UIView!
    func showCountryDialog() -> UIView {
        invokedShowCountryDialog = true
        invokedShowCountryDialogCount += 1
        return stubbedShowCountryDialogResult
    }
    var invokedShowCityDialog = false
    var invokedShowCityDialogCount = 0
    var stubbedShowCityDialogResult: UIView!
    func showCityDialog() -> UIView {
        invokedShowCityDialog = true
        invokedShowCityDialogCount += 1
        return stubbedShowCityDialogResult
    }
}
