//
//  CitiesListViewController.swift
//  WeatherApp
//
//  Created by Михаил Курис on 18.02.2022.
//

import UIKit

class CitiesListViewController: UIViewController, ViewSpecificController {
typealias RootView = CitiesListView
    
    // MARK: - Private properties
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let mainViewController = UIApplication.shared.keyWindow!.rootViewController as! MainViewController
    private var coords = [CoordsEntity]()
    private var currentListForTable = [Coord]()
    private var isSearch = false
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        coords = CoreDataFunctions().getAllCoords()
        currentListForTable = convertCoordsEntityToCoords(coordsEntity: coords)
        configure()
        
    }
    override func loadView() {
        self.view = CitiesListView()
    }
    
    private func convertCoordsEntityToCoords(coordsEntity: [CoordsEntity]) -> Coords {
        var result: Coords = []
        for entity in coordsEntity {
            let coord = Coord(
                name: entity.name,
                localNames: ["ru": entity.nameRu ?? "none"],
                lat: entity.lat,
                lon: entity.lon,
                country: entity.country,
                state: entity.state
            )
            result.append(coord)
        }
        return result
    }

}

// MARK: - Extension

extension CitiesListViewController {
    
    func configure() {
        view().tableView.delegate = self
        view().tableView.dataSource = self
        view().searchBar.delegate = self
    }
}

// MARK: - Extension UITableViewDataSource/Delegate

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentListForTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let location = "\(currentListForTable[indexPath.row].name!), \(currentListForTable[indexPath.row].state!), \(currentListForTable[indexPath.row].country!)"
        
        cell.textLabel?.text = location
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearch {
            let item = currentListForTable[indexPath.row]
            var check = true
            for coord in coords {
                if coord.name == item.name! && coord.state == item.state && coord.country == item.country {
                    check = false
                    break
                }
            }
            
            if check {
                CoreDataFunctions().addCoord(
                    name: item.name!,
                    lat: item.lat!,
                    lon: item.lon!,
                    nameRu: item.localNames!["ru"] ?? " ",
                    state: item.state!,
                    country: item.country!)
                
                coords = CoreDataFunctions().getAllCoords()
                mainViewController.reloadPageController()
                dismiss(animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Warning", message: "This city has already been added.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(alert, animated: true)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if !isSearch {
            return .delete
        } else {
            return .none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if !isSearch {
            
            if currentListForTable.count == 1 {
                let alert = UIAlertController(title: "Warning", message: "You cannot delete the last city.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(alert, animated: true)
                return
            }
            
            if editingStyle == .delete {
                tableView.beginUpdates()
                CoreDataFunctions().deleteCoord(element: coords[indexPath.row])
                coords = CoreDataFunctions().getAllCoords()
                currentListForTable = convertCoordsEntityToCoords(coordsEntity: coords)
                tableView.deleteRows(at: [indexPath], with: .fade)
                mainViewController.reloadPageController()
                tableView.endUpdates()
            }
            
        }
    }

}

// MARK: - Extension UISearchBarDelegate

extension CitiesListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else {
            return
        }
        isSearch = true
        view().tableView.reloadData()
        view().activity.startAnimating()
        ApiManager.shared.getCoords(city: searchQuery, completion: {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let getLocatoins):
                    self.currentListForTable = getLocatoins
                    self.view().activity.stopAnimating()
                    self.view().tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearch = false
            currentListForTable = convertCoordsEntityToCoords(coordsEntity: coords)
            view().tableView.reloadData()
        }
    }
}
