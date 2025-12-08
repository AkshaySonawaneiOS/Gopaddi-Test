//
//  CityTableViewCell.swift
//  Gopaddi
//
//  Created by Akshay Sonawane on 06/12/25.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var lblISOCode: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCityCountry: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func loadCell(with model: City) {
        lblCityCountry.text = "\(model.city),\(model.country)"
        lblCity.text = model.city
        lblISOCode.text = model.iso2
        
        guard let url = URL(string: model.flag_svg) else { return  }
        
        // Background queue for sync network call
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self,
                      error == nil,
                      let data = data,
                      let image = UIImage( data: data) else {
                    print("Image load failed for \(model.city): \(error?.localizedDescription ?? "Unknown")")
                    return
                }
                DispatchQueue.main.async {
                    self.imgFlag.image = image
                }
            }.resume()
    }
    
    
    
}
