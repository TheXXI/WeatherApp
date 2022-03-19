//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Михаил Курис on 07.03.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Private properties

    private var coords = [CoordsEntity]()
    private var weather = [WeatherData]()
    
    private var pageController: UIPageViewController!
    private var controllers = [UIViewController]()
    private var currentIndex: Int = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addCoordOnFirstLaunch()
        setupPageController()
        
    }
    
    // MARK: - Public methods
    
    public func reloadPageController () {
        coords.removeAll()
        controllers.removeAll()
        coords = CoreDataFunctions().getAllCoords()
        for coord in coords {
            let viewController = WeatherViewController()
            viewController.coord = coord
            controllers.append(viewController)
        }
        self.pageController?.setViewControllers([controllers[0]], direction: .forward, animated: false, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func addCoordOnFirstLaunch() {
        coords = CoreDataFunctions().getAllCoords()
        //getAllCoords()
        if coords.isEmpty {
            CoreDataFunctions().addCoord(name: "Moscow", lat: 55.7504461, lon: 37.6174943, nameRu: "Москва", state: "Moscow", country: "RU")
            CoreDataFunctions().addCoord(name: "Saint Petersburg", lat: 59.938732, lon: 30.316229, nameRu: "Санкт-Петербург", state: "Saint Petersburg", country: "RU")
            CoreDataFunctions().addCoord(name: "Moscow", lat: 55.7504461, lon: 37.6174943, nameRu: "Москва", state: "Moscow", country: "RU")
            CoreDataFunctions().addCoord(name: "Saint Petersburg", lat: 59.938732, lon: 30.316229, nameRu: "Санкт-Петербург", state: "Saint Petersburg", country: "RU")
            
            coords = CoreDataFunctions().getAllCoords()
            
        }
        //getAllCoords()
    }
    
    // MARK: - Configure UIPageController
    
    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        self.setPages()
        
        self.pageController?.setViewControllers([controllers[0]], direction: .forward, animated: false, completion: nil)
        
        self.pageController?.didMove(toParent: self)
        
        let pageControl: UIPageControl = UIPageControl.appearance(whenContainedInInstancesOf: [MainViewController.self])
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
    }
    
    private func setPages() {
        for coord in coords {
            let viewController = WeatherViewController()
            viewController.coord = coord
            controllers.append(viewController)
        }
    }
    
    // MARK: - Core Data functions
    /*private func getAllCoords() {
        coords.removeAll()
        do {
            coords = try context.fetch(CoordsEntity.fetchRequest())
        } catch {
            
        }
    }
    
    private func addCoord(name: String, lat: Double, lon: Double, nameRu: String, state: String, country: String) {
        let newElement = CoordsEntity(context: context)
        newElement.name = name
        newElement.lat = lat
        newElement.lon = lon
        newElement.nameRu = nameRu
        newElement.state = state
        newElement.country = country
        do {
            try context.save()
        } catch {
            
        }
    }
    
    private  func deleteCoord(element: CoordsEntity) {
        context.delete(element)
        do {
            try context.save()
        } catch {
            
        }
    }*/

}

// MARK: - Extension PageViewControllerDataSource/Delegate

extension MainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index > 0 {
                return controllers[index - 1]
            } else {
                return nil
            }
        }

        return nil
      
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            } else {
                return nil
            }
        }

        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}
