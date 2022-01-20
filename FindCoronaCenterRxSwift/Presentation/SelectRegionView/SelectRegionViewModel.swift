//
//  SelectRegionViewModel.swift
//  FindCoronaCenterRxSwift
//
//  Created by skillist on 2022/01/19.
//

import Foundation
import RxSwift
import RxCocoa

struct SelectRegionViewModel {
    //view -> viewModel
    var selectedRow = PublishRelay<Int>()
    
    //viewModel -> view
    var cellData: Driver<[[Center]]>
    
    init() {
        //네트워크 통신으로 데이터 가져오기
        let centersDataResult = Observable.just(())
            .flatMap { _ in
                return CenterNetwork().getCenters()
            }
            .share()
        
        cellData = centersDataResult
            .compactMap { data -> CenterAPIResponse? in
                guard case .success(let value) = data else {
                    return nil
                }
                return value
            }
            .map { $0.data }
            .map { centers in
                Dictionary(grouping: centers) { $0.sido }
            }
            .map {
                var groupedCenter: [[Center]] = []
                $0.forEach {
                    groupedCenter.append($0.value)
                }
                return groupedCenter
            }
            .asDriver(onErrorJustReturn: [[]])
    }
}
