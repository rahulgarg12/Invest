//
//  ThemesViewController.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import UIKit

final class ThemesViewController: UIViewController {
    //MARK: - Properties
    private lazy var viewModel = ThemesViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(ThemeCollectionCell.self,
                                forCellWithReuseIdentifier: ThemeCollectionCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
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
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ThemesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeCollectionCell.reuseIdentifier, for: indexPath) as! ThemeCollectionCell
        if viewModel.themes.count > indexPath.item {
            cell.set(theme: viewModel.themes[indexPath.item])
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ThemesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 60) / 2
        return CGSize(width: width, height: 160)
    }
}
