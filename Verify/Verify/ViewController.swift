//
//  ViewController.swift
//  Verify
//
//  Created by Yatharth Mahawar on 12/27/20.
//

import UIKit
import SkyFloatingLabelTextField

class ViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var cardNumber: SkyFloatingLabelTextField!
    
    @IBOutlet weak var CVV: SkyFloatingLabelTextField!
    @IBOutlet weak var monthYear: SkyFloatingLabelTextField!
    @IBOutlet weak var firstName: SkyFloatingLabelTextField!
    @IBOutlet weak var lastName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var makePayement: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardNumber.placeholder = "NAME"
        cardNumber.placeholderColor = .gray
        monthYear.placeholder = "MM/YY"
        monthYear.placeholderColor = .gray
        monthYear.delegate = self
        CVV.placeholder = "CVV"
        CVV.placeholderColor = .gray
        firstName.placeholder = "First name"
        firstName.placeholderColor = .gray
        lastName.placeholder = "Last name"
        lastName.placeholderColor = .gray
        makePayement.layer.cornerRadius = 10
        //cardNumber.addTarget(self, action: #selector(textFieldDidEndEditing(_:)) , for: .editingChanged)
    }
    
    
    
    @IBAction func makePayement(_ sender: UIButton) {
        var paymentSucess = false
        let card = checkCardNumber(input: cardNumber.text!)
        if card.valid{
            cardNumber.errorMessage = nil
            print(card.valid)
            paymentSucess = true
        }
        else {
            cardNumber.errorMessage = "Invaild Card Number"
            paymentSucess = false
        }
        let date = monthYear.text!
        let dateValue = expDateValidation(dateStr: date)
        if dateValue == "Invaild MM/YY" {
            monthYear.errorMessage = "Invaild MM/YY"
            paymentSucess = false
        }
        else {
            monthYear.errorMessage = nil
            paymentSucess = true
        }
        
        
        let cvvCode = CVV.text!
        if cvvCode.count < 3 {
            CVV.errorMessage = "inavaild code"
            paymentSucess = false
        }
        else {
            CVV.errorMessage = nil
            paymentSucess = true
        }
        
        if(firstName.text?.vaildName)!{
            firstName.errorMessage = nil
            paymentSucess = true
        }
        else {
            firstName.errorMessage = "invaild"
            paymentSucess = false
        }
        if(lastName.text?.vaildName)!{
            lastName.errorMessage = nil
            paymentSucess = true
        }
        else {
            lastName.errorMessage = "invaild"
            paymentSucess = false
        }
        
        if paymentSucess == true && card.valid == true {
            let alert = UIAlertController(title: "Payment Successful", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: .none)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            print("false")
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = (textField.text?.prefix(2))!+"/"+(textField.text?.suffix(2))!
    }
    
}

