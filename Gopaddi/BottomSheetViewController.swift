//
//  BottomSheetViewController.swift
//  Gopaddi
//
//  Created by Akshay Sonawane on 07/12/25.
//

import UIKit

class BottomSheetViewController: UIViewController {

    //MARK: - IBOutlates
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtviwTripDesc: UITextView!
    @IBOutlet weak var txtTripStyle: UITextField!
    @IBOutlet weak var txtTripName: UITextField!
    
    //MARK: - Variables
    var city:City?
    var startDate:Date?
    var endDate:Date?
    private var popoverView: UIView!
    private var optionsStackView: UIStackView!
    weak var delegate:  ViewControllerProtocol?
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTripStyle.delegate = self
        txtTripName.delegate = self
        txtviwTripDesc.layer.borderColor = UIColor.gray.cgColor
        txtviwTripDesc.layer.borderWidth = 1.0
//        if let sheet = sheetPresentationController {
//                    sheet.detents = [.medium(), .large()]
//                }
    }
    
    
    //MARK: - IBActions
    @IBAction func btnNextClicked(_ sender: Any) {
        delegate?.showCreateTripVC(city: city!, startDate: startDate ?? Date(), endDate: startDate ?? Date(), tripName: txtTripName.text ?? "", tripDescription: txtviwTripDesc.text ?? "", travelStyle: txtTripStyle.text ?? "")
        dismiss(animated: true)
    }
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
}



extension BottomSheetViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if ((txtTripName.text?.isEmpty) != nil) && ((txtTripStyle.text?.isEmpty) != nil) {
            btnNext.isEnabled = true
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtTripStyle {
            showTripStyle()
            return false
        }
        return true
    }
    
    
    
     func showTripStyle() {
        // Remove existing popover
        popoverView?.removeFromSuperview()
        
        // Create popover container
        popoverView = UIView()
        popoverView.backgroundColor = .systemBackground
        popoverView.layer.cornerRadius = 12
        popoverView.layer.shadowColor = UIColor.black.cgColor
        popoverView.layer.shadowOpacity = 0.2
        popoverView.layer.shadowOffset = CGSize(width: 0, height: 4)
        popoverView.layer.shadowRadius = 8
        
        view.addSubview(popoverView)
        popoverView.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack view for 2-4 options
        optionsStackView = UIStackView()
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 0
        optionsStackView.distribution = .fillEqually
        
        popoverView.addSubview(optionsStackView)
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add tappable option buttons
        let options = ["solo", "couple", "family", "group"]
        for option in options {
            let button = createOptionButton(title: option)
            optionsStackView.addArrangedSubview(button)
        }
        
        // Position below textfield
        NSLayoutConstraint.activate([
            popoverView.topAnchor.constraint(equalTo: txtTripStyle.bottomAnchor, constant: 8),
            popoverView.leadingAnchor.constraint(equalTo: txtTripStyle.leadingAnchor),
            popoverView.trailingAnchor.constraint(equalTo: txtTripStyle.trailingAnchor),
            popoverView.heightAnchor.constraint(equalToConstant: 44 * CGFloat(options.count)), // 44px per option
            
            optionsStackView.topAnchor.constraint(equalTo: popoverView.topAnchor, constant: 8),
            optionsStackView.leadingAnchor.constraint(equalTo: popoverView.leadingAnchor, constant: 8),
            optionsStackView.trailingAnchor.constraint(equalTo: popoverView.trailingAnchor, constant: -8),
            optionsStackView.bottomAnchor.constraint(equalTo: popoverView.bottomAnchor, constant: -8)
        ])
        
        UIView.animate(withDuration: 0.2) {
            self.popoverView.alpha = 1
        }
    }
    
    private func createOptionButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.contentHorizontalAlignment = .leading
        button.tintColor = .label
        button.backgroundColor = .clear
        
        button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
        return button
    }

    @objc private func optionTapped(_ sender: UIButton) {
        txtTripStyle.text = sender.titleLabel?.text
        hidePopover()
        // Handle selection
        print("Selected: \(sender.titleLabel?.text ?? "")")
    }
    
    private func hidePopover() {
        UIView.animate(withDuration: 0.2, animations: {
            self.popoverView.alpha = 0
        }) { _ in
            self.popoverView.removeFromSuperview()
        }
    }
}
