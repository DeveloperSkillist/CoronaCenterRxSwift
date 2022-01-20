//
//  SelectCenterView.swift
//  FindCoronaCenterRxSwift
//
//  Created by skillist on 2022/01/20.
//

import Foundation
import RxSwift
import RxCocoa

class SelectCenterView: UIViewController {
    var disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(SelectCenterViewCell.self, forCellReuseIdentifier: "SelectCenterViewCell")
        return tableView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SelectCenterViewModel) {
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, data in
                guard let cell = tv.dequeueReusableCell(withIdentifier: "SelectCenterViewCell") as? SelectCenterViewCell else {
                    return UITableViewCell()
                }
                cell.setData(center: data)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.navigationTitle
            .drive {
                self.navigationItem.title = $0
            }
            .disposed(by: disposeBag)
        
        Observable.zip(
            tableView.rx.itemSelected,
            tableView.rx.modelSelected(Center.self)
        )
            .bind { [weak self] indexPath, data in
                self?.tableView.deselectRow(at: indexPath, animated: true)
                
                let detailMapViewModel = DetailMapViewModel(center: data)
                let detailMapView = DetailMapView()
                detailMapView.bind(detailMapViewModel)
                self?.navigationController?.pushViewController(detailMapView, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
