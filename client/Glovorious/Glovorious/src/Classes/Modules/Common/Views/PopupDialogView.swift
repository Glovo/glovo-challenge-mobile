//
//  PopupDialogView.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 24/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import UIKit

protocol PopupDialogViewDelegate: class {
    func popupDialogViewDelegateSetCountryDataSource() -> [Country]
    func popupDialogViewDelegateDidSelectCountryCell(object: Country)
    func popupDialogViewDelegateSetCityDataSource() -> [City]
    func popupDialogViewDelegateDidSelectCityCell(object: City)
}

class PopupDialogView: UIView {
    
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var loadingView: LoadingView!
    
    var superView: UIView?
    var data: [Any]?
    var title: String?
    var isCountry: Bool = false
    weak var delegate: PopupDialogViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(with frame: CGRect, title: String, isCountry: Bool) {
        super.init(frame: frame)
        self.title = title
        self.isCountry = isCountry
        self.setup(frame: frame)
    }
    
    func doLoading(_ load: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !load
            self.loadingView.load(load)
        }
        
    }
    
    func setup(frame: CGRect) {
        let sView = UINib(nibName: "PopupDialogView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        sView.frame = frame
        sView.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        superView = sView
        dialogView = UINib.init(nibName: "PopupDialogView", bundle: nil).instantiate(withOwner: self, options: nil)[1] as? UIView
        dialogView.center = CGPoint.init(x: sView.frame.midX, y: sView.bounds.midY)
        addSubview(sView)
        addSubview(dialogView)
        doLoading(true)
        labelHeader.text = self.title
        tableView.register(UINib.init(nibName: "DialogViewCell", bundle: nil), forCellReuseIdentifier: "DialogViewCell")
        animateView(dialogView)
        
    }

    func animateView(_ view: UIView) {
        self.doLoading(false)
        view.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        let transform:CGAffineTransform = .identity
        UIView.animate(withDuration: 1.50, delay: 0, usingSpringWithDamping: 0.50, initialSpringVelocity: 4.00, options: .allowUserInteraction, animations: {
            view.transform = transform;
        }) { _ in
            self.tableView.reloadData()
            
        }
    }
    
    func removeView() {
        self.doLoading(false)
        UIView.animate(withDuration: 0.5, animations: {
            self.superView?.alpha = 0
            self.dialogView.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        removeView()
    }
}

extension PopupDialogView: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isCountry ? delegate?.popupDialogViewDelegateSetCountryDataSource().count ?? 0 : delegate?.popupDialogViewDelegateSetCityDataSource().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DialogViewCell") as! DialogViewCell
        
        if isCountry {
            if let countries = delegate?.popupDialogViewDelegateSetCountryDataSource() {
                cell.labelName.text = countries[indexPath.row].name
            }
        } else {
            if let cities = delegate?.popupDialogViewDelegateSetCityDataSource() {
                cell.labelName.text = cities[indexPath.row].name
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        doLoading(true)
        guard let delegate = self.delegate else {
            return
        }
        if isCountry {
            delegate.popupDialogViewDelegateDidSelectCountryCell(object: delegate.popupDialogViewDelegateSetCountryDataSource()[indexPath.row])
        } else {
            delegate.popupDialogViewDelegateDidSelectCityCell(object: delegate.popupDialogViewDelegateSetCityDataSource()[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
