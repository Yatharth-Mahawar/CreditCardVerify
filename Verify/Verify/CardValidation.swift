//
//  CardValidation.swift
//  Verify
//
//  Created by Yatharth Mahawar on 12/28/20.
//

import Foundation
extension ViewController {
        enum CardType: String {
            case Unknown, American, Visa, MasterCard,Discover
            
            static let allCards = [Visa, MasterCard,Discover]
            
            var regex : String {
                switch self {
                case .Visa:
                    return "^4[0-9]{6,}([0-9]{3})?$"
                case .MasterCard:
                    return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
                case .Discover:
                    return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
                case .American:
                    return "^3[47][0-9]{13}$"
                default:
                    return ""
                }
            }
        }
        
        func matchesRegex(regex: String!, text: String!) -> Bool {
            do {
                let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
                let nsString = text as NSString
                let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
                return (match != nil)
            } catch {
                return false
            }
        }
        
        func luhnCheck(_ number: String) -> Bool {
            var sum = 0
            let digitStrings = number.reversed().map { String($0) }
            
            for tuple in digitStrings.enumerated() {
                if let digit = Int(tuple.element) {
                    let odd = tuple.offset % 2 == 1
                    
                    switch (odd, digit) {
                    case (true, 9):
                        sum += 9
                    case (true, 0...8):
                        sum += (digit * 2) % 9
                    default:
                        sum += digit
                    }
                } else {
                    return false
                }
            }
            return sum % 10 == 0
        }
        
        func checkCardNumber(input: String) -> (type: CardType, formatted: String, valid: Bool) {
            // Get only numbers from the input string
            let numberOnly = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            
            var type: CardType = .Unknown
            var formatted = ""
            var valid = false
            
            // detect card type
            for card in CardType.allCards {
                if (matchesRegex(regex: card.regex, text: numberOnly)) {
                    type = card
                    break
                }
            }
            
            // check validity
            valid = luhnCheck(numberOnly)
            
            // format
            var formatted4 = ""
            for character in numberOnly {
                if formatted4.count == 4 {
                    formatted += formatted4 + " "
                    formatted4 = ""
                }
                formatted4.append(character)
            }
            
            formatted += formatted4 // the rest
            
            // return the tuple
            return (type, formatted, valid)
        }
        
        func expDateValidation(dateStr:String) -> String {
            var returnValue = ""
            let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
            let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)
            
            let enteredYear = Int(dateStr.suffix(2)) ?? 0 // get last two digit from entered string as year
            let enteredMonth = Int(dateStr.prefix(2)) ?? 0 // get first two digit from entered string as month
            print(dateStr) // This is MM/YY Entered by user
            
            if enteredYear > currentYear {
                if (1 ... 12).contains(enteredMonth) {
                    print("Entered Date Is Right")
                } else {
                    returnValue = "Invaild MM/YY"
                    return returnValue
                }
            } else if currentYear == enteredYear {
                if enteredMonth >= currentMonth {
                    if (1 ... 12).contains(enteredMonth) {
                        print("Entered Date Is Right")
                    } else {
                        returnValue = "Invaild MM/YY"
                        return returnValue
                    }
                } else {
                    returnValue = "Invaild MM/YY"
                    return returnValue
                }
            } else {
                returnValue = "Invaild MM/YY"
                return returnValue
            }
            return returnValue
        }
    }

    extension String {
        var vaildName:Bool {
            let firstName = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z]")
            return firstName.evaluate(with: self)
        }
    }



