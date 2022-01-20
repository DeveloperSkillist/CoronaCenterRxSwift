//
//  DetailMapView.swift
//  FindCoronaCenterRxSwift
//
//  Created by skillist on 2022/01/20.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import MapKit

class DetailMapView: UIViewController {
    let disposeBag = DisposeBag()
    
    private let mapView = MKMapView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: DetailMapViewModel) {
        viewModel.mapAnnotation
            .drive(onNext: {
                self.mapView.addAnnotation($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.annotationRegion
            .drive(onNext: {
                self.mapView.setRegion($0, animated: false)
            })
            .disposed(by: disposeBag)
    }
    
    
    private func attribute() {
        
    }
    
    private func layout() {
        [
            mapView
        ].forEach {
            view.addSubview($0)
        }
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
