//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Михаил Курис on 11.03.2022.

import UIKit

class WeatherView: UIView {
    
    // MARK: - Public properties
    
    public var headerView: HeaderView!
    
    // MARK: - Private properties
    
    private var weatherDataModel: WeatherData?
    private let width = Int(UIScreen.main.bounds.width)
    
    private var activity: UIActivityIndicatorView!
    private var scrollView: UIScrollView!
    private var currentView: CurrentView!
    private var collectionHourlyWeather: UICollectionView!
    private var dailyViews = [DailyView]()
    private var currentDetailsViews = [CurrentDetailsView]()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        activity = UIActivityIndicatorView()
        addSubview(activity)
        setActivityViewConstraints()
        //activity.startAnimating()
        
        createHourlyCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func createHeaderView(location: String) {
        headerView = HeaderView()
        headerView.configure(location: location)
        addSubview(headerView)
        setHeaderViewConstraints()
    }
    
    public func createScrollView(weatherDataModel: WeatherData) {
        self.weatherDataModel = weatherDataModel
        activity.stopAnimating()
        scrollView = UIScrollView()
        addSubview(scrollView)
        setScrollViewConstraints()

        //currentView = CurrentView(model: weatherDataModel.current!)
        currentView = CurrentView()
        currentView.configure(model: weatherDataModel.current!)
        scrollView.addSubview(currentView)
        setCurrentViewViewConstraints()
        
        scrollView.addSubview(collectionHourlyWeather)
        setCollectionHourlyWeatherConstraints()
        collectionHourlyWeather.reloadData()
        
        createDailyViews()
        
        createCurrentDetailsViews()
        
        //currentDetailsView = CurrentDetailsView()
        //currentDetailsView = CurrentDetailsView(model: weatherDataModel.current!)
        //scrollView.addSubview(currentDetailsView)
        //addCurrentDetailsViewConstraints()
    }
    
    // MARK: - Private methods
    
    private func createHourlyCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 90)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionHourlyWeather = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionHourlyWeather.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.identifier)
        collectionHourlyWeather.showsHorizontalScrollIndicator = false
    }
    
    private func createDailyViews() {
        for index in 0...7 {
            let daily = DailyView()
            daily.configure(model: (weatherDataModel?.daily![index])!)
            dailyViews.append(daily)
            scrollView.addSubview(dailyViews[index])
            setDailyViewConstraints(index: index)
        }
    }
    
    private func createCurrentDetailsViews() {
        for index in 0...6 {
            let currentDetailsView = CurrentDetailsView()
            switch index {
            case 0: //УФ-индекс
                currentDetailsView.setTitle()
            case 1: //УФ-индекс
                let value: String = String((weatherDataModel?.current?.uvi)!)
                currentDetailsView.configure(title: "УФ-индекс:", value: value)
            case 2: //Ветер
                let value: String = "\((weatherDataModel?.current?.windSpeed)!) м/с (доделать)"
                currentDetailsView.configure(title: "Ветер:", value: value)
            case 3: //Влажность
                let value: String = "\((weatherDataModel?.current?.humidity)!)%"
                currentDetailsView.configure(title: "Влажность:", value: value)
            case 4: //Давление
                let pressure = Double((weatherDataModel?.current?.pressure)!) * 0.75
                let value: String = "\(NSString(format: "%.0f", round(pressure))) мм рт. ст."
                currentDetailsView.configure(title: "Давление:", value: value)
            case 5: //Восход
                let value = TimeFormatter.getTime(format: "HH:mm", unixtime: (weatherDataModel?.current?.sunrise)!)
                currentDetailsView.configure(title: "Восход:", value: value)
            case 6: //Закат
                let value = TimeFormatter.getTime(format: "HH:mm", unixtime: (weatherDataModel?.current?.sunset)!)
                currentDetailsView.configure(title: "Закат:", value: value)
            default:
                break
            }
            currentDetailsViews.append(currentDetailsView)
            scrollView.addSubview(currentDetailsViews[index])
            setCurrentDetailsViewConstraints(index: index)
            
        }
    }
    
    // MARK: - Add Constraints
    
    private func setActivityViewConstraints() {
        activity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    activity.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                    activity.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                ])
    }
    
    private func setHeaderViewConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.bottomAnchor),
            //оставляет белое поле внизу
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
       ])
    }
    
    private func setCurrentViewViewConstraints() {
        currentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentView.heightAnchor.constraint(equalToConstant: 160),
            currentView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            currentView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            currentView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        ])
    }
    
    private func setCollectionHourlyWeatherConstraints() {
        collectionHourlyWeather.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionHourlyWeather.heightAnchor.constraint(equalToConstant: 90),
            collectionHourlyWeather.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            collectionHourlyWeather.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            collectionHourlyWeather.topAnchor.constraint(equalTo: currentView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setDailyViewConstraints(index: Int) {
        dailyViews[index].translatesAutoresizingMaskIntoConstraints = false
        var constraints = [
            dailyViews[index].heightAnchor.constraint(equalToConstant: 40),
            dailyViews[index].leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            dailyViews[index].trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor)
        ]
        
        if index == 0 {
            constraints.append(dailyViews[index].topAnchor.constraint(equalTo: collectionHourlyWeather.bottomAnchor, constant: 20))
        } else {
            constraints.append(dailyViews[index].topAnchor.constraint(equalTo: dailyViews[index-1].bottomAnchor, constant: 5))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setCurrentDetailsViewConstraints(index: Int) {
        currentDetailsViews[index].translatesAutoresizingMaskIntoConstraints = false
        var constraints = [
            currentDetailsViews[index].heightAnchor.constraint(equalToConstant: 25),
            currentDetailsViews[index].leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            currentDetailsViews[index].trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor)
        ]
        if index == 6 {
            constraints.append(currentDetailsViews[6].bottomAnchor.constraint(equalTo: scrollView.bottomAnchor))
        }
        if index == 0 {
            constraints.append(currentDetailsViews[index].topAnchor.constraint(equalTo: dailyViews[dailyViews.count-1].bottomAnchor, constant: 20))
        } else {
            constraints.append(currentDetailsViews[index].topAnchor.constraint(equalTo: currentDetailsViews[index-1].bottomAnchor, constant: 5))
        }
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        collectionHourlyWeather?.delegate = self
        collectionHourlyWeather?.dataSource = self
    }

}

extension WeatherView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if weatherDataModel?.hourly?.count == nil {
            return 0
        } else {
            return (weatherDataModel?.hourly!.count)! / 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as! HourlyWeatherCell

        cell.configure(model: (weatherDataModel?.hourly?[indexPath.item])!)
            /*time: (weatherDataModel?.hourly?[indexPath.item].dt)!,
            icon: (weatherDataModel?.hourly?[indexPath.item].weather![0].icon)!,
            temp: (weatherDataModel?.hourly?[indexPath.item].temp)!)*/
                    
        return cell
    }
}
