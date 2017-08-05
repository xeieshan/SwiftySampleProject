//
//  SPAllowedCharsTextField.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 19/01/2011.
//  Copyright © 2016 <#Project Developer#> All rights reserved.
//

import UIKit
private var maxLengths = [UITextField: Int]()
class SPAllowedCharsTextField: UITextField, UITextFieldDelegate {
    
    @IBInspectable var allowedChars: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        autocorrectionType = .no
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return prospectiveText.containsOnlyCharactersIn(allowedChars)
    }
    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            // Any text field with a set max length will call the limitLength
            // method any time it's edited (i.e. when the user adds, removes,
            // cuts, or pastes characters to/from the text field).
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControlEvents.editingChanged
            )
        }
    }
    
    func limitLength(_ textField: UITextField) {
        guard let prospectiveText = textField.text, prospectiveText.characters.count > maxLength else {
            return
        }
        
        // If the change in the text field's contents will exceed its maximum length,
        // allow only the first [maxLength] characters of the resulting text.
        let selection = selectedTextRange
        text = prospectiveText.substring(
            with: Range<String.Index>(prospectiveText.startIndex ..< prospectiveText.characters.index(prospectiveText.startIndex, offsetBy: maxLength))
        )
        selectedTextRange = selection
    }
}


extension String {
    
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(_ matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
}
