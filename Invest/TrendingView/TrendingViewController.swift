//
//  TrendingViewController.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import UIKit
import MBProgressHUD

final class TrendingViewController: UIViewController {
    //MARK: - Enum
    private enum HeaderTitle: String, CaseIterable {
        case gainer = "Top Gainers"
        case seller = "Top Sellers"
    }
    
    //MARK: - Properties
    private lazy var viewModel = TrendingViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TrendingTableCell.self,
                           forCellReuseIdentifier: TrendingTableCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configView()
        
        fetchData()
    }
    
    
    //MARK: - Private Methods
    private func configView() {
        view.backgroundColor = UIColor.white

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func fetchData() {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        viewModel.getTrendingRates(successHandler: { [weak self] forexRates in
            if let quotes = forexRates.quote {
                self?.viewModel.trending = quotes.compactMap { TrendingQuote(dictionaryLiteral: ($0.key, $0.value)) }
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                
                hud.hide(animated: true)
            }
        }) { (error) in
            print(error)
            
            DispatchQueue.main.async {
                hud.hide(animated: true)
            }
        }
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return HeaderTitle.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.trending.isEmpty {
            return 0
        }
        return section == 0 ? 6: 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        view.backgroundColor = .white
        
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 0, width: view.bounds.width - 20, height: view.bounds.height)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.black
        label.text = section == 0 ? HeaderTitle.gainer.rawValue : HeaderTitle.seller.rawValue
        view.addSubview(label)
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableCell.reuseIdentifier) as! TrendingTableCell
        if viewModel.trending.count > indexPath.row {
            cell.set(trending: viewModel.trending[indexPath.row])
        }
        return cell
    }
}
