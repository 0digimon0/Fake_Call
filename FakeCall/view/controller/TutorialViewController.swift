//
//  TutorialViewController.swift
//  FakeCall
//
//  Created by admin on 7/2/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class TutorialViewController: UIPageViewController {

    let initialPage = 0
    var pages:[TutorialPageController] = []
    var pageControl:UIPageControl!
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        initPages()
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        // pageControl
        self.pageControl = UIPageControl()
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = initialPage
        self.view.addSubview(self.pageControl)
        pageControl.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
    
    func initPages() {
        for _index in 1...8 {
            let page = TutorialPageController()
            page.pageIndex = _index
            pages.append(page)
        }
    }
    
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        // set the pageControl.currentPage to the index of the current viewController in pages
//        let viewControllerIndex = (pageViewController as! TutorialPageController).pageIndex
//        self.pageControl.currentPage = viewControllerIndex
//    }

    

}

extension TutorialViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let viewControllerIndex = (viewController as! TutorialPageController).pageIndex - 1
        if viewControllerIndex == 0 {
            return nil
        } else {
            return self.pages[viewControllerIndex - 1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let viewControllerIndex = (viewController as! TutorialPageController).pageIndex - 1
        if viewControllerIndex == pages.count - 1 {
            return nil
        } else {
            return self.pages[viewControllerIndex + 1]
        }
    }


}
