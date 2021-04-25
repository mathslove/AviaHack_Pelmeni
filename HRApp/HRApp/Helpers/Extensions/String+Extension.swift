//
//  String+Extension.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 23.04.2021.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var isEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: self)
    }
    
    var isPassword: Bool {
        self.count >= 6
    }
}
