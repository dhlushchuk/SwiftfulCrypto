//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 11.12.24.
//

import SwiftUI

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
