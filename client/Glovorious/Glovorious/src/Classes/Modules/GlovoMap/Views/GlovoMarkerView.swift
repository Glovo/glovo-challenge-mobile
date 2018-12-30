//
//  GlovoMarkerView.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 29/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation
import MapKit

class GlovoMarkerView: MKAnnotationView {
    var city: City?
    
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        image = UIImage(named: "icon-current-annotation")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            image = UIImage(named: "icon-current-annotation")
        }
    }
}
