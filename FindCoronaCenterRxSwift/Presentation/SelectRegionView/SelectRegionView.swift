//
//  SelectRegionView.swift
//  FindCoronaCenterRxSwift
//
//  Created by skillist on 2022/01/19.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SelectRegionView: UIViewController {
    var disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let marginSize: CGFloat = 10
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = marginSize
        layout.minimumInteritemSpacing = marginSize
        layout.sectionInset = UIEdgeInsets(top: marginSize, left: marginSize, bottom: marginSize, right: marginSize)
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        
        collectionView.register(SelectRegionCollectionViewCell.self, forCellWithReuseIdentifier: "SelectRegionCollectionViewCell")
        
        return collectionView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SelectRegionViewModel) {
        viewModel.cellData
            .drive(collectionView.rx.items) { cv, row, data in
                guard let cell = cv.dequeueReusableCell(withReuseIdentifier: "SelectRegionCollectionViewCell", for: IndexPath(row: row, section: 0)) as? SelectRegionCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.setupData(title: data.first?.sido.rawValue ?? "-", number: String("(\(data.count))"))
                return cell
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected([Center].self)
            .subscribe(onNext: {
                print("select : \($0.count)")
                let selectCenterView = SelectCenterView()
                selectCenterView.bind(SelectCenterViewModel(centers: $0))
                self.navigationController?.pushViewController(selectCenterView, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        navigationItem.title = "지역"
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SelectRegionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((view.frame.width - (10*2))/2) - 5, height: 100)
    }
}
