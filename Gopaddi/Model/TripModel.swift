//
//  TripModel.swift
//  Gopaddi
//
//  Created by Akshay Sonawane on 08/12/25.
//

struct Trip: Codable {
    let city: City
    let tripName: String
    let tripStyle: String
    let tripDesc: String
    let hotelDetails: String
    let flightDetails: String
    let activityDetails: String
    let start: String
    let end: String
}
