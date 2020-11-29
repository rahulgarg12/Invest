//
//  ExplorePageViewController.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import UIKit

protocol ExplorePageViewControllerDelegate: class {
    func didFinishScroll(index: Int)
}


enum ExplorePageType: Int {
    case category
    case theme
    case trending
}


final class ExplorePageViewController: UIPageViewController {
    //MARK: Properties
    var pages = [UIViewController]()
    weak var viewDelegate: ExplorePageViewControllerDelegate?
    
    lazy var categoryPage = CategoryViewController()
    lazy var themePage = ThemesViewController()
    lazy var trendingPage = TrendingViewController()
    
    //MARK: Overridden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        pages.append(categoryPage)
        pages.append(themePage)
        pages.append(trendingPage)
        
        setViewController(type: .category)
    }
    
    //MARK: - Helper Methods
    func setViewController(type: ExplorePageType) {
        var index: Int
        switch type {
        case .category: index = 0
        case .theme: index = 1
        case .trending: index = 2
        }
        
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}


//MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension ExplorePageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
            
        if viewControllerIndex == 0 {
            return pages.last
        } else {
            return pages[viewControllerIndex - 1]
        }
    }
            
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
            
        if viewControllerIndex < pages.count - 1 {
            return pages[viewControllerIndex + 1]
        } else {
            return pages.first
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers,
              let viewControllerIndex = pages.firstIndex(of: viewControllers[0])
            else { return }
        
        viewDelegate?.didFinishScroll(index: viewControllerIndex)
    }
}
