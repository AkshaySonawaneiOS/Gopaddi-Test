//
//  CommonFunctions.swift
//  Gopaddi
//
//  Created by Akshay Sonawane on 08/12/25.
//

import UIKit

// Common classes and extentions will be created in this file

class CommonFunctions{
    
    static let shared = CommonFunctions()
    func daysBetween(start: String, end: String) -> String {
        // Ignore time components, compare by calendar days
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        let startDate = formatter.date(from: start)
        let endDate = formatter.date(from: end)
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: startDate!)
        let endOfDay = calendar.startOfDay(for: endDate!)
        
        let components = calendar.dateComponents([.day], from: startOfDay, to: endOfDay)
        let dayCount = components.day ?? 0   // e.g. 5
        
        if dayCount == 1 {
            return "1 day"
        } else {
            return "\(dayCount) days"
        }
    }
    
    
    
}
// MARK: - UIViewController Extension
extension UIViewController {
    func createSwiftUITitleLabel(_ title: String) -> UILabel {
           let label = UILabel()
           label.text = title
           label.font = UIFont(name: "Santoshi-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
           label.textColor = .label
           label.textAlignment = .left
           
           // Perfect sizing
           let maxSize = CGSize(width: 150, height: 26)
           let labelSize = label.sizeThatFits(maxSize)
           label.frame = CGRect(x: 0, y: 0, width: labelSize.width + 8, height: 26)
           return label
       }
    
    func createBackButton(isbackButton: Bool) -> UIBarButtonItem {
            let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: isbackButton ? "arrow.backward" : "xmark"), for: .normal)
            backButton.tintColor = .label
            backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            backButton.addTarget(self, action: #selector(globalBackTapped), for: .touchUpInside)
            return UIBarButtonItem(customView: backButton)
        }
        @objc private func globalBackTapped() {
            navigationController?.popViewController(animated: true)
        }
    func setupLeftNavTitle(title: String, isbackButton: Bool) {
           let titleLabel = createSwiftUITitleLabel(title)
           navigationItem.leftBarButtonItems = [
               createBackButton(isbackButton: isbackButton),
               UIBarButtonItem(customView: titleLabel)
           ]
       }
}


// MARK: - Encodable Extension
extension Encodable {
    typealias JSONDictionary = [String: Any]
    func toJSONDictionary() -> JSONDictionary? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self),
              let json = try? JSONSerialization.jsonObject(with: data) as? JSONDictionary else {
            return nil
        }
        return json
    }
}
