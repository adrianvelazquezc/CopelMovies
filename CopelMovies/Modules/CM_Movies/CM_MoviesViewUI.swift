//
//  CM_MoviesViewUI.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation
import UIKit

protocol CM_MoviesViewUIDelegate {
    
}

class CM_MoviesViewUI: UIView{
    var delegate: CM_MoviesViewUIDelegate?
    var navigationController: UINavigationController?
    
    public convenience init(
        navigation: UINavigationController,
        delegate: CM_MoviesViewUIDelegate){
            self.init()
            self.delegate = delegate
            self.navigationController = navigation
            
            setUI()
            setConstraints()
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUI(){
        self.backgroundColor = .white
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            
        ])
    }
}
