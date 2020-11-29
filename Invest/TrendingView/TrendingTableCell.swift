//
//  TrendingTableCell.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import UIKit

final class TrendingTableCell: UITableViewCell {
    //MARK: - Properties
    lazy private var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    lazy private var trendingImageView: UIImageView = {
        let trendingImageView = UIImageView()
        trendingImageView.contentMode = .scaleAspectFill
        trendingImageView.clipsToBounds = true
        trendingImageView.image = UIImage(named: "slack")
        return trendingImageView
    }()
    
    lazy private var trendingHeaderLabel: UILabel = {
        let trendingHeaderLabel = UILabel()
        trendingHeaderLabel.font = UIFont.boldSystemFont(ofSize: 15)
        trendingHeaderLabel.textColor = UIColor.black
        return trendingHeaderLabel
    }()
    
    lazy private var trendingSubheaderLabel: UILabel = {
        let trendingSubheaderLabel = UILabel()
        trendingSubheaderLabel.font = UIFont.systemFont(ofSize: 15)
        trendingSubheaderLabel.textColor = UIColor.darkGray
        return trendingSubheaderLabel
    }()
    
    lazy private var priceView: UIView = {
        let priceView = UIView()
        priceView.backgroundColor = UIColor(hex: "71d8b6")
        priceView.clipsToBounds = true
        return priceView
    }()
    
    lazy private var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.boldSystemFont(ofSize: 12)
        priceLabel.textColor = UIColor.white
        priceLabel.textAlignment = .center
        return priceLabel
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
            make.top.left.bottom.right.equalTo(self.contentView)
        }
        
        let mainStackView = getMainStackView()
        containerView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView).offset(20)
            make.top.equalTo(self.containerView).offset(20)
            make.bottom.equalTo(self.containerView).offset(-20)
            make.right.equalTo(self.containerView).offset(-20)
        }
        
        trendingImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(35)
        }
    }
    
    private func getMainStackView() -> UIStackView {
        let mainStackView = UIStackView()
        mainStackView.alignment = .center
        mainStackView.axis = .horizontal
        mainStackView.spacing = 20
        mainStackView.distribution = .fill
        mainStackView.addArrangedSubview(trendingImageView)
        mainStackView.addArrangedSubview(getTextStackView())
        
        mainStackView.addArrangedSubview(priceView)
        priceView.snp.makeConstraints { (make) in
            make.height.equalTo(25)
        }
        priceView.layer.cornerRadius = 25/2
        
        priceView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.priceView)
            make.left.equalTo(self.priceView).offset(12)
            make.right.equalTo(self.priceView).offset(-12)
        }
        
        return mainStackView
    }
    
    private func getTextStackView() -> UIStackView {
        let textStackView = UIStackView()
        textStackView.alignment = .leading
        textStackView.axis = .vertical
        textStackView.spacing = 2
        textStackView.distribution = .fill
        textStackView.addArrangedSubview(trendingHeaderLabel)
        textStackView.addArrangedSubview(trendingSubheaderLabel)
        return textStackView
    }
    
    
    //MARK: - Outside Accessors
    func set(trending: TrendingQuote) {
        trendingHeaderLabel.text = trending.keys.first
        trendingSubheaderLabel.text = trending.keys.first
        priceLabel.text = "+\(trending.values.first?.rounded(toPlaces: 2) ?? 0)"
    }
}
