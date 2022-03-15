//
//  CitiesListViewController.swift
//  WeatherApp
//
//  Created by Михаил Курис on 18.02.2022.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    private var coords = [CoordsEntity]()
    
    weak var mainController: MainViewController?
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = UISearchBar.Style.default
        search.placeholder = " Search..."
        search.sizeToFit()
        search.isTranslucent = false
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coords = CoreDataFunctions().getAllCoords()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.tableHeaderView = searchBar
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = coords[indexPath.row].nameRu
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        /*if coords.count == 1 {
            let alert = UIAlertController(title: "Ошибка", message: "Нельзя удалить последний город.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Назад", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }*/
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            CoreDataFunctions().deleteCoord(element: coords[indexPath.row])
            coords = CoreDataFunctions().getAllCoords()
            tableView.deleteRows(at: [indexPath], with: .fade)
            //UIApplication.sharedApplication().windows[0].rootViewController
            
            tableView.endUpdates()
        }
    }
}

extension CitiesListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        guard let searchQuery = searchBar.text else {
            return
        }
        ApiManager.shared.getCoords(city: searchQuery, completion: {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let getLocatoins):
                    //print(getLocatoins)
                    for locatoin in getLocatoins {
                        print(locatoin.localNames?["ru"]!)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}
