//
//  CategoryTableCell.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import UIKit

final class CategoryTableCell: UITableViewCell {
    //MARK: - Properties
    lazy private var containerView: UIView = {
        let containerView = UIView()
        containerView.clipsToBounds = true
        return containerView
    }()
    
    lazy private var categoryImageView: UIImageView = {
        let categoryImageView = UIImageView()
        categoryImageView.contentMode = .scaleAspectFill
        categoryImageView.clipsToBounds = true
        return categoryImageView
    }()
    
    lazy private var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 15)
        categoryLabel.textColor = UIColor.white
        return categoryLabel
    }()
    
    static var reuseIdentifier: String {
        return self.className
    }
    
    
    //MARK: - Overriden Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private Helpers
    private func configView() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(15)
            make.top.equalTo(self.contentView).offset(15)
            make.bottom.equalTo(self.contentView).offset(-15)
            make.right.equalTo(self.contentView).offset(-15)
        }
        containerView.layer.cornerRadius = 80/2
        
        let mainStackView = getMainStackView()
        containerView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView).offset(18)
            make.top.equalTo(self.containerView).offset(12)
            make.bottom.equalTo(self.containerView).offset(-12)
            make.right.equalTo(self.containerView).offset(-12)
        }
        
        categoryImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
        }
        categoryImageView.layer.cornerRadius = 40/2
    }
    
    private func getMainStackView() -> UIStackView {
        let mainStackView = UIStackView()
        mainStackView.alignment = .center
        mainStackView.axis = .horizontal
        mainStackView.spacing = 12
        mainStackView.distribution = .fill
        mainStackView.addArrangedSubview(categoryImageView)
        mainStackView.addArrangedSubview(categoryLabel)
        return mainStackView
    }
    
    
    //MARK: - Outside Accessors
    func set(category: CategoryModel) {
        if let backgroundHex = category.backgroundHex {
            containerView.backgroundColor = UIColor(hex: backgroundHex)
        }
        if let imageName = category.imageName {
            categoryImageView.image = UIImage(named: imageName)
        }
        categoryLabel.text = category.headline
    }
}
