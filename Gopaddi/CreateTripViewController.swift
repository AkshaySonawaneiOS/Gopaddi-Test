//
//  CreateTripViewController.swift
//  Gopaddi
//
//  Created by Akshay Sonawane on 07/12/25.
//

import UIKit

class CreateTripViewController: UIViewController {
    
    // MARK: - IBOutlates
    @IBOutlet weak var btnCreateTrip: UIButton!
    @IBOutlet weak var lblFlightDetails: UILabel!
    @IBOutlet weak var lblActivityDetail: UILabel!
    @IBOutlet weak var lblHotelDetail: UILabel!
    @IBOutlet weak var viwActivityNoData: UIView!
    @IBOutlet weak var viwActivityDetails: UIView!
    @IBOutlet weak var viwHotelNoData: UIView!
    @IBOutlet weak var viwHotelDetails: UIView!
    @IBOutlet weak var viwFlightsNoData: UIView!
    @IBOutlet weak var viwFlightDetails: UIView!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblTripName: UILabel!
    @IBOutlet weak var lblCityCountryStyle: UILabel!
    
    // MARK: - Variables
    weak var delegate:  ViewControllerProtocol?
    var destination: City?
    var tripStyle: String?
    var tripDesc: String?
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLeftNavTitle(title: "Plan a Trip", isbackButton: true)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions
    @IBAction func btnAddActivitiesClicked(_ sender: Any) {
        self.viwActivityNoData.isHidden = true
        self.viwActivityDetails.isHidden = false
    }
    @IBAction func btnAddHotelsClicked(_ sender: Any) {
        self.viwHotelNoData.isHidden = true
        self.viwHotelDetails.isHidden = false
    }
    @IBAction func btnAddFlightsClicked(_ sender: Any) {
        self.viwFlightsNoData.isHidden = true
        self.viwFlightDetails.isHidden = false
    }
    @IBAction func btnRemoveFlight(_ sender: Any) {
        self.viwFlightsNoData.isHidden = false
        self.viwFlightDetails.isHidden = true
    }
    @IBAction func btnRemoveHotel(_ sender: Any) {
        self.viwHotelNoData.isHidden = false
        self.viwHotelDetails.isHidden = true
    }
    @IBAction func btnRemoveActivity(_ sender: Any) {
        self.viwActivityNoData.isHidden = false
        self.viwActivityDetails.isHidden = true
    }
    @IBAction func btnCreateTripClicked(_ sender: Any) {
        
        // Call Create Trip API (if available) to store the trip to database
        
        delegate?.createTrip(trip: Trip(city: destination!, tripName: lblTripName.text ?? "", tripStyle: tripStyle ?? "", tripDesc: tripDesc ?? "", hotelDetails: lblHotelDetail.text ?? "", flightDetails: lblFlightDetails.text ?? "", activityDetails: lblActivityDetail.text ?? "",start: lblStartDate.text ?? "", end: lblEndDate.text ?? ""))
        dismiss(animated: true)
    }
}
