//
//  PlanTripViewModel.swift
//  Gopaddi
//
//  Created by Akshay Sonawane on 07/12/25.
//

import Foundation

class PlanTripViewModel {
    
    func loadCities() -> [City] {
        guard let url = Bundle.main.url(forResource: "Cities", withExtension: "json") else {
            print("❌ Cities.json not found")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let cities = try JSONDecoder().decode([City].self, from: data)
            return cities
        } catch {
            print("❌ Failed to decode JSON: \(error)")
            return []
        }
    }
    
    
    func loadTrips ()  {
        //Call API to get the list of the trips to show and pass it to the view
    }
    
    func SaveTrip () {
        //Call API to save the Trip
    }
    
    func giveDestinationDetails (city: City, style: String) -> String {
       return "\(city.city), \(city.country) | \(style)"
    }
    
    
    func daysBetween(start: Date, end: Date) -> String {
        // Ignore time components, compare by calendar days
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: start)
        let endOfDay = calendar.startOfDay(for: end)
        
        let components = calendar.dateComponents([.day], from: startOfDay, to: endOfDay)
        let dayCount = components.day ?? 0   // e.g. 5
        
        if dayCount == 1 {
            return "1 day"
        } else {
            return "\(dayCount) days"
        }
    }

    
}
