//
//  LoadingView.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 22/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let view = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        addSubview(view)
        self.contentView = view
    }
    
    func load(_ isLoad: Bool) {
        if isLoad {
            indicatorView.startAnimating()
        } else {
            indicatorView.stopAnimating()
        }
    }
}
