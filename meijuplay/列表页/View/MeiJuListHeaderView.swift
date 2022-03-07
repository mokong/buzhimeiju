//
//  MeiJuListHeaderView.swift
//  meijuplay
//
//  Created by Horizon on 21/12/2021.
//

import UIKit

class MeiJuListHeaderView: UICollectionReusableView {
    // MARK: - view life cycle
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.custom.background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - utils
    
    
    // MARK: - action
    
    
    // MARK: - other
    class func reuseId() -> String {
        return "MeiJuListHeaderView"
    }


}
