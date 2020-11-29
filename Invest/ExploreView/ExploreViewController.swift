//
//  ExploreViewController.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import UIKit
import SnapKit

final class ExploreViewController: UIPageViewController {
    //MARK: - Enum
    private enum SegmentedControlSection: String {
        case category = "Category"
        case themes = "Themes"
        case trending = "Trending"
    }
    
    //MARK: - Properties
    lazy private var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    lazy private var sliderView: UIView = {
        let sliderView = UIView()
        return sliderView
    }()
    
    lazy private var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 15)
        categoryLabel.textColor = headerColor
        categoryLabel.text = SegmentedControlSection.category.rawValue
        categoryLabel.textAlignment = .center
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCategory(_:)))
        categoryLabel.addGestureRecognizer(gesture)
        categoryLabel.isUserInteractionEnabled = true
        categoryLabel.tag = 0
        
        return categoryLabel
    }()
    lazy private var themesLabel: UILabel = {
        let themesLabel = UILabel()
        themesLabel.font = UIFont.boldSystemFont(ofSize: 15)
        themesLabel.textColor = headerColor
        themesLabel.text = SegmentedControlSection.themes.rawValue
        themesLabel.textAlignment = .center
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCategory(_:)))
        themesLabel.addGestureRecognizer(gesture)
        themesLabel.isUserInteractionEnabled = true
        themesLabel.tag = 1
        
        return themesLabel
    }()
    lazy private var trendingLabel: UILabel = {
        let trendingLabel = UILabel()
        trendingLabel.font = UIFont.boldSystemFont(ofSize: 15)
        trendingLabel.textColor = headerColor
        trendingLabel.text = SegmentedControlSection.trending.rawValue
        trendingLabel.textAlignment = .center
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCategory(_:)))
        trendingLabel.addGestureRecognizer(gesture)
        trendingLabel.isUserInteractionEnabled = true
        trendingLabel.tag = 2
        
        return trendingLabel
    }()
    lazy private var sliderBar: UIView = {
        let sliderBar = UIView()
        sliderBar.backgroundColor = selectedHeaderColor
        return sliderBar
    }()
    
    private var selectedHeaderColor = UIColor(hex: "4c52c7")
    private var headerColor = UIColor.darkGray
    
    lazy var pageVC = ExplorePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    
    //MARK: - Overridden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    
    //MARK: - Private Methods
    private func configView() {
        title = "Explore"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.view.backgroundColor = .white
        
        initSliderView()
        initPageView()
    }
    
    private func initSliderView() {
        view.addSubview(sliderView)
        sliderView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        let separatorWidth: CGFloat = 1
        let separatorHeight: CGFloat = 10
        let width = (view.bounds.width / 3) - separatorWidth
        let height = 38
        sliderView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.sliderView)
            make.left.equalTo(self.sliderView.snp.left)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        let separator1View = UIView()
        separator1View.backgroundColor = UIColor.gray
        sliderView.addSubview(separator1View)
        separator1View.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.sliderView.snp.centerY)
            make.left.equalTo(self.categoryLabel.snp.right)
            make.width.equalTo(separatorWidth)
            make.height.equalTo(separatorHeight)
        }
        
        sliderView.addSubview(themesLabel)
        themesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.sliderView)
            make.left.equalTo(separator1View.snp.right)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        let separator2View = UIView()
        separator2View.backgroundColor = UIColor.gray
        sliderView.addSubview(separator2View)
        separator2View.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.sliderView.snp.centerY)
            make.left.equalTo(self.themesLabel.snp.right)
            make.width.equalTo(separatorWidth)
            make.height.equalTo(separatorHeight)
        }
        
        sliderView.addSubview(trendingLabel)
        trendingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.sliderView)
            make.left.equalTo(self.themesLabel.snp.right)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        sliderView.addSubview(sliderBar)
        sliderBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.categoryLabel.snp.bottom)
            make.bottom.equalTo(self.sliderView)
            make.left.equalTo(self.categoryLabel.snp.left)
            make.width.equalTo(width)
            make.height.equalTo(2)
        }
        scrollSlider(to: .category)
    }
    
    private func initPageView() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.sliderView.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.pageVC = ExplorePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            self.pageVC.view.frame = self.containerView.bounds
            self.pageVC.viewDelegate = self
            self.addChild(self.pageVC)
            self.containerView.addSubview(self.pageVC.view)
            self.pageVC.didMove(toParent: self)
        }
    }
    
    private func scrollSlider(to type: ExplorePageType?) {
        var left: ConstraintItem
        
        switch type {
        case .category:
            left = categoryLabel.snp.left
            categoryLabel.textColor = selectedHeaderColor
            themesLabel.textColor = headerColor
            trendingLabel.textColor = headerColor
            
        case .theme:
            left = themesLabel.snp.left
            categoryLabel.textColor = headerColor
            themesLabel.textColor = selectedHeaderColor
            trendingLabel.textColor = headerColor
            
        case .trending:
            left = trendingLabel.snp.left
            categoryLabel.textColor = headerColor
            themesLabel.textColor = headerColor
            trendingLabel.textColor = selectedHeaderColor
            
        default: return
        }
        
        let width = view.bounds.width / 3
        sliderBar.snp.remakeConstraints { (make) in
            make.top.equalTo(self.categoryLabel.snp.bottom)
            make.bottom.equalTo(self.sliderView)
            make.left.equalTo(left)
            make.width.equalTo(width)
            make.height.equalTo(2)
        }
    }
    
    //MARK: - Selector Methods
    @objc private func didTapCategory(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        
        switch tag {
        case 0: pageVC.setViewController(type: ExplorePageType.category)
        case 1: pageVC.setViewController(type: ExplorePageType.theme)
        case 2: pageVC.setViewController(type: ExplorePageType.trending)
        default: return
        }
        
        scrollSlider(to: ExplorePageType(rawValue: tag))
    }
}


//MARK: - ExplorePageViewControllerDelegate
extension ExploreViewController: ExplorePageViewControllerDelegate {
    func didFinishScroll(index: Int) {
        scrollSlider(to: ExplorePageType(rawValue: index))
    }
}
