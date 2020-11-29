//
//  CategoryViewController.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import UIKit
import SnapKit

final class CategoryViewController: UIViewController {
    //MARK: - Properties
    private lazy var viewModel = CategoryViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableCell.self,
                           forCellReuseIdentifier: CategoryTableCell.reuseIdentifier)
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
    }
    
    
    //MARK: - Private Methods
    private func configView() {
        view.backgroundColor = UIColor.white

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableCell.reuseIdentifier) as! CategoryTableCell
        if viewModel.categories.count > indexPath.row {
            cell.set(category: viewModel.categories[indexPath.row])
        }
        return cell
    }
}
