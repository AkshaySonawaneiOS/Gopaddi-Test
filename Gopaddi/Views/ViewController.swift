//
//  ViewController.swift
//  Gopaddi
//
//  Created by Akshay Sonawane on 06/12/25.
//

import UIKit



protocol ViewControllerProtocol: AnyObject {
    func didSelectCity(_ city: City)
    func showCreateTripVC (city: City, startDate: Date, endDate: Date, tripName: String, tripDescription: String, travelStyle: String)
    func createTrip(trip: Trip)
}


class ViewController: UIViewController {
    
    // MARK: - IBOutlates
    @IBOutlet weak var viwPlannedTrips: UIView!
    @IBOutlet weak var btnCreateTrip: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
    @IBOutlet weak var btnSelectCity: UIButton!
    @IBOutlet weak var tblPlannedTrips: UITableView!
    @IBOutlet weak var btnStartDate: UIButton!
    
    //MARK: - Variables
    let viewModel = PlanTripViewModel ()
    var selectedStartDate: Date?
    var selectedEndDate: Date?
    var selectedCity: City?
    var plannedTrips: [Trip] = []
        
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Can load the planned trips by calling api with ViewModel
        if plannedTrips.isEmpty {
            tblPlannedTrips.isHidden = true
        } else {
            tblPlannedTrips.isHidden = false
        }
        self.tblPlannedTrips.delegate = self
        self.tblPlannedTrips.dataSource = self
        self.setupLeftNavTitle(title: "Plan a Trip", isbackButton: true)
    }
    
    
    
    // MARK: - IBActions
    @IBAction func btnCreateTripClicked(_ sender: Any) {
        let sheetVC = storyboard?.instantiateViewController(identifier: "BottomSheetViewController") as! BottomSheetViewController
        sheetVC.city = selectedCity
        sheetVC.startDate = selectedStartDate
        sheetVC.endDate = selectedEndDate
        sheetVC.delegate = self
        sheetVC.modalPresentationStyle = .pageSheet
        present(sheetVC, animated: true)
    }
    @IBAction func btnEndDate(_ sender: Any) {
        showDatePicker(for: sender as! UIButton)
    }
    @IBAction func btnStartDateClicked(_ sender: Any) {
        showDatePicker(for: sender as! UIButton)
    }
    @IBAction func btnSelectCityClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CitySearchViewController") as! CitySearchViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - User Defined Methods
    func setBtnTitles () {
        btnSelectCity.setTitle("", for: .normal)
        btnEndDate.setTitle("", for: .normal)
        btnStartDate.setTitle("", for: .normal)
    }
}


extension ViewController {
    
    func showDatePicker(for button: UIButton) {
        let alert = UIAlertController(title: "Select Date", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        if button == btnEndDate && selectedStartDate != nil {
                datePicker.minimumDate = selectedStartDate
            }
        alert.view.addSubview(datePicker)

        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -10),
            datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50),
            datePicker.heightAnchor.constraint(equalToConstant: 180)
        ])

        alert.addAction(UIAlertAction(title: "Done", style: .default) { _ in
            if button == self.btnEndDate {
                self.selectedEndDate = datePicker.date
            } else {
                self.selectedStartDate = datePicker.date
            }
            self.updateButtonTitle(button, with: datePicker.date)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alert, animated: true)
    }

    func updateButtonTitle(_ button: UIButton, with date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"  // ex: 24 March 2024
        let formattedDate = formatter.string(from: date)
        button.setBackgroundImage(nil, for: .normal)
        button.setTitle(formattedDate, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
    }
}


extension ViewController : ViewControllerProtocol {
    func createTrip(trip: Trip) {
        self.plannedTrips.append(trip)
    }
    
    func showCreateTripVC(city: City, startDate: Date, endDate: Date, tripName: String, tripDescription: String, travelStyle: String) {
        
        let vc = storyboard?.instantiateViewController(identifier: "CreateTripViewController") as! CreateTripViewController

        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        
        vc.tripName = tripName
        vc.tripStartDate = formatter.string(from: selectedStartDate ?? startDate)
        vc.tripEnddate = formatter.string(from: selectedEndDate ?? endDate)
        vc.tripCityCountryStyle = self.viewModel.giveDestinationDetails(city: city, style: travelStyle)
        vc.destination = city
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectCity(_ city: City) {
        self.selectedCity = city
        self.btnSelectCity.setBackgroundImage(nil, for: .normal)
        self.btnSelectCity.setTitle(city.city, for: .normal)
        self.btnSelectCity.layer.cornerRadius = 5
        self.btnSelectCity.layer.borderColor = UIColor.gray.cgColor
        self.btnSelectCity.layer.borderWidth = 1
        
    }
}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plannedTrips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlannedTripTableViewCell", for: indexPath) as? PlannedTripTableViewCell {
            if plannedTrips.count > 0 {
                cell.lblTripName.text = plannedTrips[indexPath.row].tripName
                cell.lblStartDate.text = plannedTrips[indexPath.row].start
                cell.lblTripDays.text = CommonFunctions.shared.daysBetween(start: plannedTrips[indexPath.row].start, end: plannedTrips[indexPath.row].end)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    
    
    
}
