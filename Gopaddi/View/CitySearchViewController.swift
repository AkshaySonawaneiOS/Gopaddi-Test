//
//  CitySearchViewController.swift
//  Gopaddi
//
//  Created by Akshay Sonawane on 07/12/25.
//

import UIKit

class CitySearchViewController: UIViewController {

    @IBOutlet weak var txtCitySearch: UITextField!
    @IBOutlet weak var tblCityList: UITableView!
    
    
    //MARK: - Variable
    let viewModel = PlanTripViewModel ()
    var cities : [City] = []
    var filterCities : [City] = []
    weak var delegate:  ViewControllerProtocol?
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLeftNavTitle(title: "Where", isbackButton: false)
        self.tblCityList.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "cityCell")
        self.tblCityList.delegate = self
        self.tblCityList.dataSource = self
        cities = viewModel.loadCities()
        self.tblCityList.isHidden = true
        self.txtCitySearch.delegate = self
    }
}


//MARK: - Extensions
extension CitySearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityTableViewCell {
            if !filterCities.isEmpty {
                self.tblCityList.isHidden = false
                cell.loadCell(with: filterCities[indexPath.row])
                return cell
            }
        }
        self.tblCityList.isHidden = true
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = filterCities[indexPath.row]
        delegate?.didSelectCity(selectedCity)
        navigationController?.popViewController(animated: true)
    }
}


extension CitySearchViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        self.filterCities.removeAll()
        self.filterCities = cities.filter { City in
            City.city.lowercased().contains(textField.text?.lowercased() ?? "")
        }
        self.tblCityList.reloadData()
        return false
    }
    
    
    
}
