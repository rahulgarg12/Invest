//
//  ThemeCollectionCell.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import UIKit

final class ThemeCollectionCell: UICollectionViewCell {
    //MARK: - Properties
    lazy private var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
        containerView.backgroundColor = UIColor(hex: "f5f5f5")
        return containerView
    }()
    
    lazy private var themeImageView: UIImageView = {
        let themeImageView = UIImageView()
        themeImageView.contentMode = .scaleAspectFill
        themeImageView.clipsToBounds = true
        return themeImageView
    }()
    
    lazy private var themeLabel: UILabel = {
        let themeLabel = UILabel()
        themeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        themeLabel.textColor = UIColor.darkGray
        themeLabel.numberOfLines = 2
        themeLabel.textAlignment = .center
        return themeLabel
    }()
    
    static var reuseIdentifier: String {
        return self.className
    }
    
    //MARK: - Overriden Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private Helpers
    private func configView() {
        backgroundColor = .white
        contentView.backgroundColor = .white
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.contentView)
        }
        
        let mainStackView = getMainStackView()
        containerView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView).offset(15)
            make.left.equalTo(self.containerView).offset(10)
            make.bottom.right.equalTo(self.containerView).offset(-10)
        }
        
        themeImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(75)
        }
    }
    
    private func getMainStackView() -> UIStackView {
        let mainStackView = UIStackView()
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.spacing = 15
        mainStackView.distribution = .fill
        mainStackView.addArrangedSubview(themeImageView)
        mainStackView.addArrangedSubview(themeLabel)
        return mainStackView
    }
    
    
    //MARK: - Outside Accessors
    func set(theme: ThemeModel) {
        if let imageName = theme.imageName {
            themeImageView.image = UIImage(named: imageName)
        }
        themeLabel.text = theme.headline
    }
}
