//
//  String+Extension.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import UIKit

public func getLabelText(text: String, font: UIFont = .systemFont(ofSize: 15, weight: .bold)) -> NSMutableAttributedString {
    let multipleAttributes: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.foregroundColor: CM_NetworkManager.shared.textColor,
        NSAttributedString.Key.font: font
    ]
    let attributedString = NSMutableAttributedString(string: text, attributes: multipleAttributes)
    
    return attributedString
}

public func parseDate(_ str : String, oldDateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = oldDateFormat
    
    let date = dateFormatter.date(from: str) ?? Date()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let formattedDate = dateFormatter.string(from: date)
    return formattedDate
}
