//
//  SelectCenterViewModel.swift
//  FindCoronaCenterRxSwift
//
//  Created by skillist on 2022/01/20.
//

import Foundation
import RxSwift
import RxCocoa

struct SelectCenterViewModel {
    
    //view -> viewModel
    
    //viewModel -> view
    var cellData : Driver<[Center]>
    var navigationTitle: Driver<String>
    
    init(centers: [Center]) {
        cellData = Observable.just(centers)
            .asDriver(onErrorDriveWith: .empty())
            
        navigationTitle = Observable.just(centers.first?.sido.rawValue ?? "-")
            .asDriver(onErrorJustReturn: "-")
    }
}
