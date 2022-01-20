//
//  DetailMapViewModel.swift
//  FindCoronaCenterRxSwift
//
//  Created by skillist on 2022/01/20.
//

import Foundation
import RxSwift
import RxCocoa
import MapKit

struct DetailMapViewModel {
    
    //viewModel -> view
    var mapAnnotation: Driver<MKPointAnnotation>
    var annotationRegion: Driver<MKCoordinateRegion>
    
    init(center: Center) {
        
        let clLocation = Observable.just(center)
            .map {
                return CLLocationCoordinate2D(
                    latitude: Double($0.lat) ?? .zero,
                    longitude: Double($0.lng) ?? .zero
                )
            }
            .share()
        
        mapAnnotation = clLocation
            .map {
                let annotation = MKPointAnnotation()
                annotation.coordinate = $0
                annotation.title = center.facilityName
                annotation.subtitle = center.phoneNumber
                return annotation
            }
            .asDriver(onErrorDriveWith: .empty())
        
        annotationRegion = clLocation
            .map {
                let span = MKCoordinateSpan(
                    latitudeDelta: 0.003,
                    longitudeDelta: 0.003
                )
                return MKCoordinateRegion(center: $0, span: span)
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
